param(
    [string]$Root = (Get-Location).Path,
    [string]$CatalogPath = "catalogo.csv"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$script:CheckCount = 0
$script:ErrorCount = 0
$script:WarningCount = 0

function Write-Check {
    param(
        [ValidateSet("PASS", "FAIL", "WARN", "INFO")]
        [string]$Level,
        [string]$Code,
        [string]$Message
    )

    $script:CheckCount++

    switch ($Level) {
        "FAIL" { $script:ErrorCount++ }
        "WARN" { $script:WarningCount++ }
    }

    Write-Host ("[{0}] {1} - {2}" -f $Level, $Code, $Message)
}

function Test-StartsWithOrdinal {
    param(
        [string]$Value,
        [string]$Prefix
    )

    return $Value.StartsWith($Prefix, [StringComparison]::Ordinal)
}

function Test-IsHttpReference {
    param([string]$Value)

    $uri = $null
    $created = [Uri]::TryCreate($Value, [UriKind]::Absolute, [ref]$uri)

    if (-not $created) {
        return $false
    }

    return ($uri.Scheme -eq "http" -or $uri.Scheme -eq "https")
}

function Get-LocalFullPath {
    param(
        [string]$RepositoryRoot,
        [string]$RelativePath
    )

    $platformPath = $RelativePath -replace '/', '\'
    return [IO.Path]::GetFullPath((Join-Path $RepositoryRoot $platformPath))
}

function Test-IsInsideRoot {
    param(
        [string]$RepositoryRoot,
        [string]$FullPath
    )

    $rootWithSeparator = $RepositoryRoot.TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
    return $FullPath.StartsWith($rootWithSeparator, [StringComparison]::OrdinalIgnoreCase)
}

function Test-DuplicateColumn {
    param(
        [object[]]$Rows,
        [string]$Column,
        [ValidateSet("FAIL", "WARN", "INFO")]
        [string]$DuplicateLevel
    )

    $values = @(
        $Rows |
            ForEach-Object { [string]$_.$Column } |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    )

    $duplicateGroups = @(
        $values |
            Group-Object -Property { $_.ToLowerInvariant() } |
            Where-Object { $_.Count -gt 1 }
    )

    if ($duplicateGroups.Count -eq 0) {
        Write-Check "PASS" ("CAT-DUP-{0}" -f $Column.ToUpperInvariant()) (
            "No duplicate non-empty values in column: {0}" -f $Column
        )
        return
    }

    foreach ($group in $duplicateGroups) {
        Write-Check $DuplicateLevel ("CAT-DUP-{0}" -f $Column.ToUpperInvariant()) (
            "Duplicate value in column {0}: {1} ({2} occurrences)" -f
            $Column,
            $group.Group[0],
            $group.Count
        )
    }
}

try {
    $resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
    Set-Location -LiteralPath $resolvedRoot

    Write-Host ""
    Write-Host "SKF CATALOG VALIDATOR v1.0.0" -ForegroundColor Cyan
    Write-Host ("Root: {0}" -f $resolvedRoot)
    Write-Host ("Catalog: {0}" -f $CatalogPath)
    Write-Host ""

    $insideWorkTree = (git rev-parse --is-inside-work-tree 2>$null)

    if ($LASTEXITCODE -ne 0 -or $insideWorkTree.Trim() -ne "true") {
        Write-Check "FAIL" "GIT-001" "The selected root is not a Git working tree."
        throw "Validation cannot continue outside a Git working tree."
    }

    Write-Check "PASS" "GIT-001" "Git working tree detected."

    $catalogFullPath = Join-Path $resolvedRoot $CatalogPath

    if (-not (Test-Path -LiteralPath $catalogFullPath -PathType Leaf)) {
        Write-Check "FAIL" "CAT-FILE" ("Catalog file is missing: {0}" -f $CatalogPath)
        Write-Host ""
        Write-Host "SUMMARY"
        Write-Host ("Checks: {0}" -f $script:CheckCount)
        Write-Host ("Errors: {0}" -f $script:ErrorCount)
        Write-Host ("Warnings: {0}" -f $script:WarningCount)
        Write-Host "RESULT: FAIL"
        exit 1
    }

    Write-Check "PASS" "CAT-FILE" ("Catalog file exists: {0}" -f $CatalogPath)

    $catalogBytes = [IO.File]::ReadAllBytes($catalogFullPath)
    $strictUtf8 = New-Object -TypeName System.Text.UTF8Encoding -ArgumentList @($false, $true)

    try {
        $null = $strictUtf8.GetString($catalogBytes)
        Write-Check "PASS" "CAT-UTF8" "Catalog is valid UTF-8."
    }
    catch {
        Write-Check "FAIL" "CAT-UTF8" "Catalog contains invalid UTF-8 bytes."
    }

    $hasBom = (
        $catalogBytes.Length -ge 3 -and
        $catalogBytes[0] -eq 0xEF -and
        $catalogBytes[1] -eq 0xBB -and
        $catalogBytes[2] -eq 0xBF
    )

    if ($hasBom) {
        Write-Check "WARN" "CAT-BOM" "Catalog contains an UTF-8 BOM."
    }
    else {
        Write-Check "PASS" "CAT-BOM" "Catalog does not contain an UTF-8 BOM."
    }

    $crCount = @($catalogBytes | Where-Object { $_ -eq 13 }).Count

    if ($crCount -eq 0) {
        Write-Check "PASS" "CAT-EOL" "Catalog uses LF line endings."
    }
    else {
        Write-Check "FAIL" "CAT-EOL" (
            "Catalog contains CR bytes; expected LF line endings. CR bytes: {0}" -f $crCount
        )
    }

    $expectedColumns = @(
        "id",
        "titulo",
        "orgao",
        "dominio",
        "tipo_fonte",
        "caminho_fonte",
        "caminho_dossie",
        "ano",
        "versao",
        "status",
        "nivel_autoridade",
        "checksum_sha256",
        "observacoes"
    )

    $expectedHeader = '"' + ($expectedColumns -join '","') + '"'
    $actualHeader = Get-Content -LiteralPath $catalogFullPath -Encoding UTF8 -TotalCount 1

    if ($actualHeader -ceq $expectedHeader) {
        Write-Check "PASS" "CAT-HEADER" "Catalog header and column order are canonical."
    }
    else {
        Write-Check "FAIL" "CAT-HEADER" "Catalog header or column order is not canonical."
        Write-Host ("Expected: {0}" -f $expectedHeader)
        Write-Host ("Actual:   {0}" -f $actualHeader)
    }

    $rows = @()

    try {
        $rows = @(Import-Csv -LiteralPath $catalogFullPath -Encoding UTF8 -Delimiter ',')
        Write-Check "PASS" "CAT-PARSE" "Catalog was parsed successfully."
    }
    catch {
        Write-Check "FAIL" "CAT-PARSE" ("CSV parsing failed: {0}" -f $_.Exception.Message)
    }

    if ($rows.Count -gt 0) {
        Write-Check "PASS" "CAT-RECORDS" ("Catalog records found: {0}" -f $rows.Count)
    }
    else {
        Write-Check "FAIL" "CAT-RECORDS" "Catalog must contain at least one record."
    }

    $parsedColumnsValid = $false

    if ($rows.Count -gt 0) {
        $parsedColumns = @($rows[0].PSObject.Properties.Name)
        $parsedColumnsValid = (($parsedColumns -join "`n") -ceq ($expectedColumns -join "`n"))

        if ($parsedColumnsValid) {
            Write-Check "PASS" "CAT-COLUMNS" "Parsed columns match the canonical contract."
        }
        else {
            Write-Check "FAIL" "CAT-COLUMNS" "Parsed columns do not match the canonical contract."
        }
    }

    $requiredFields = @(
        "id",
        "titulo",
        "orgao",
        "dominio",
        "tipo_fonte",
        "caminho_fonte",
        "status",
        "nivel_autoridade"
    )

    $technicalTokenFields = @(
        "tipo_fonte",
        "status",
        "nivel_autoridade"
    )

    if (-not $parsedColumnsValid -and $rows.Count -gt 0) {
        Write-Check "INFO" "CAT-RECORD-SKIP" (
            "Record-level validation skipped because parsed columns are not canonical."
        )
    }

    if ($parsedColumnsValid) {
    for ($index = 0; $index -lt $rows.Count; $index++) {
        $row = $rows[$index]
        $lineNumber = $index + 2
        $recordId = [string]$row.id
        $recordLabel = $(if ([string]::IsNullOrWhiteSpace($recordId)) {
            "line {0}" -f $lineNumber
        }
        else {
            "{0} (line {1})" -f $recordId, $lineNumber
        })

        foreach ($field in $requiredFields) {
            $value = [string]$row.$field

            if ([string]::IsNullOrWhiteSpace($value)) {
                Write-Check "FAIL" "CAT-REQUIRED" (
                    "Required field is empty: {0}; record {1}" -f $field, $recordLabel
                )
            }
            else {
                Write-Check "PASS" "CAT-REQUIRED" (
                    "Required field is populated: {0}; record {1}" -f $field, $recordLabel
                )
            }
        }

        foreach ($field in $expectedColumns) {
            $value = [string]$row.$field

            if ($value -cne $value.Trim()) {
                Write-Check "FAIL" "CAT-WHITESPACE" (
                    "Leading or trailing whitespace in field {0}; record {1}" -f
                    $field,
                    $recordLabel
                )
            }
        }

        if ($recordId -cmatch '^[A-Z0-9]+(?:-[A-Z0-9]+)+$') {
            Write-Check "PASS" "CAT-ID" ("Canonical identifier: {0}" -f $recordLabel)
        }
        else {
            Write-Check "FAIL" "CAT-ID" ("Invalid canonical identifier: {0}" -f $recordLabel)
        }

        $domain = [string]$row.dominio

        if ($domain -cmatch '^[a-z0-9]+(?:[-/][a-z0-9]+)*$') {
            Write-Check "PASS" "CAT-DOMAIN" ("Portable domain token: {0}" -f $recordLabel)
        }
        else {
            Write-Check "FAIL" "CAT-DOMAIN" ("Invalid domain token: {0}" -f $recordLabel)
        }

        foreach ($field in $technicalTokenFields) {
            $value = [string]$row.$field

            if ($value -cmatch '^[a-z0-9]+(?:-[a-z0-9]+)*$') {
                Write-Check "PASS" "CAT-TOKEN" (
                    "Portable technical token in {0}: {1}" -f $field, $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-TOKEN" (
                    "Invalid technical token in {0}: {1}" -f $field, $recordLabel
                )
            }
        }

        $version = [string]$row.versao

        if ([string]::IsNullOrWhiteSpace($version)) {
            Write-Check "INFO" "CAT-VERSION" ("Version not informed: {0}" -f $recordLabel)
        }
        elseif ($version -cmatch '^[a-z0-9]+(?:[.-][a-z0-9]+)*$') {
            Write-Check "PASS" "CAT-VERSION" ("Portable version token: {0}" -f $recordLabel)
        }
        else {
            Write-Check "FAIL" "CAT-VERSION" ("Invalid version token: {0}" -f $recordLabel)
        }

        $year = [string]$row.ano

        if ([string]::IsNullOrWhiteSpace($year)) {
            Write-Check "INFO" "CAT-YEAR" ("Year not informed: {0}" -f $recordLabel)
        }
        elseif ($year -cmatch '^[0-9]{4}$') {
            Write-Check "PASS" "CAT-YEAR" ("Valid four-digit year: {0}" -f $recordLabel)
        }
        else {
            Write-Check "FAIL" "CAT-YEAR" ("Invalid year; expected four digits: {0}" -f $recordLabel)
        }

        $sourcePath = [string]$row.caminho_fonte
        $sourceIsHttp = Test-IsHttpReference -Value $sourcePath

        if ($sourceIsHttp) {
            Write-Check "PASS" "CAT-SOURCE-REF" (
                "External HTTP source reference accepted: {0}" -f $recordLabel
            )
        }
        else {
            if ($sourcePath -match '\\') {
                Write-Check "FAIL" "CAT-SOURCE-SLASH" (
                    "Local source path must use forward slashes: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "PASS" "CAT-SOURCE-SLASH" (
                    "Local source path uses forward slashes: {0}" -f $recordLabel
                )
            }

            if (Test-StartsWithOrdinal -Value $sourcePath -Prefix "01-fontes/") {
                Write-Check "PASS" "CAT-SOURCE-LAYER" (
                    "Local source path is under 01-fontes: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-SOURCE-LAYER" (
                    "Local source path must be under 01-fontes: {0}" -f $recordLabel
                )
            }

            $sourceTraversal = @($sourcePath -split '/' | Where-Object { $_ -eq ".." }).Count

            if ($sourceTraversal -eq 0) {
                Write-Check "PASS" "CAT-SOURCE-TRAVERSAL" (
                    "Local source path has no parent traversal: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-SOURCE-TRAVERSAL" (
                    "Local source path contains parent traversal: {0}" -f $recordLabel
                )
            }

            $sourceFullPath = Get-LocalFullPath `
                -RepositoryRoot $resolvedRoot `
                -RelativePath $sourcePath

            if (Test-IsInsideRoot -RepositoryRoot $resolvedRoot -FullPath $sourceFullPath) {
                Write-Check "PASS" "CAT-SOURCE-ROOT" (
                    "Local source resolves inside repository root: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-SOURCE-ROOT" (
                    "Local source resolves outside repository root: {0}" -f $recordLabel
                )
            }

            $sourceExists = Test-Path -LiteralPath $sourceFullPath -PathType Leaf

            if ($sourceExists) {
                Write-Check "PASS" "CAT-SOURCE-EXISTS" (
                    "Cataloged source file exists: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-SOURCE-EXISTS" (
                    "Cataloged source file is missing: {0}" -f $recordLabel
                )
            }

            $sourceSegments = @($sourcePath -split '/')

            if ($sourceSegments -ccontains $recordId) {
                Write-Check "PASS" "CAT-SOURCE-ID-DIR" (
                    "Source path contains its canonical ID directory: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-SOURCE-ID-DIR" (
                    "Source path does not contain its canonical ID directory: {0}" -f $recordLabel
                )
            }

            $sourceFileName = [IO.Path]::GetFileName($sourcePath)

            if ($sourceFileName.StartsWith(($recordId + "-"), [StringComparison]::Ordinal)) {
                Write-Check "PASS" "CAT-SOURCE-ID-FILE" (
                    "Source filename starts with its canonical ID: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-SOURCE-ID-FILE" (
                    "Source filename must start with its canonical ID: {0}" -f $recordLabel
                )
            }

            $checksum = [string]$row.checksum_sha256

            if ([string]::IsNullOrWhiteSpace($checksum)) {
                Write-Check "FAIL" "CAT-CHECKSUM" (
                    "Checksum is required for a source stored in the repository: {0}" -f
                    $recordLabel
                )
            }
            elseif ($checksum -cmatch '^[a-f0-9]{64}$') {
                Write-Check "PASS" "CAT-CHECKSUM-FORMAT" (
                    "Checksum uses canonical lowercase SHA-256 format: {0}" -f $recordLabel
                )

                if ($sourceExists) {
                    $actualChecksum = (
                        Get-FileHash -LiteralPath $sourceFullPath -Algorithm SHA256
                    ).Hash.ToLowerInvariant()

                    if ($actualChecksum -ceq $checksum) {
                        Write-Check "PASS" "CAT-CHECKSUM-MATCH" (
                            "Checksum matches the cataloged source: {0}" -f $recordLabel
                        )
                    }
                    else {
                        Write-Check "FAIL" "CAT-CHECKSUM-MATCH" (
                            "Checksum mismatch for cataloged source: {0}" -f $recordLabel
                        )
                    }
                }
            }
            else {
                Write-Check "FAIL" "CAT-CHECKSUM-FORMAT" (
                    "Checksum must be 64 lowercase hexadecimal characters: {0}" -f
                    $recordLabel
                )
            }
        }

        if ($sourceIsHttp) {
            $externalChecksum = [string]$row.checksum_sha256

            if ([string]::IsNullOrWhiteSpace($externalChecksum)) {
                Write-Check "INFO" "CAT-CHECKSUM" (
                    "Checksum not informed for external source reference: {0}" -f $recordLabel
                )
            }
            elseif ($externalChecksum -cmatch '^[a-f0-9]{64}$') {
                Write-Check "PASS" "CAT-CHECKSUM-FORMAT" (
                    "External reference checksum uses canonical SHA-256 format: {0}" -f
                    $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-CHECKSUM-FORMAT" (
                    "External reference checksum has invalid format: {0}" -f $recordLabel
                )
            }
        }

        $dossierPath = [string]$row.caminho_dossie

        if ([string]::IsNullOrWhiteSpace($dossierPath)) {
            Write-Check "INFO" "CAT-DOSSIER" (
                "Dossier path not informed: {0}" -f $recordLabel
            )
        }
        else {
            if ($dossierPath -match '\\') {
                Write-Check "FAIL" "CAT-DOSSIER-SLASH" (
                    "Dossier path must use forward slashes: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "PASS" "CAT-DOSSIER-SLASH" (
                    "Dossier path uses forward slashes: {0}" -f $recordLabel
                )
            }

            if (Test-StartsWithOrdinal -Value $dossierPath -Prefix "02-dossies/") {
                Write-Check "PASS" "CAT-DOSSIER-LAYER" (
                    "Dossier path is under 02-dossies: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-DOSSIER-LAYER" (
                    "Dossier path must be under 02-dossies: {0}" -f $recordLabel
                )
            }

            $dossierTraversal = @($dossierPath -split '/' | Where-Object { $_ -eq ".." }).Count

            if ($dossierTraversal -eq 0) {
                Write-Check "PASS" "CAT-DOSSIER-TRAVERSAL" (
                    "Dossier path has no parent traversal: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-DOSSIER-TRAVERSAL" (
                    "Dossier path contains parent traversal: {0}" -f $recordLabel
                )
            }

            $dossierFullPath = Get-LocalFullPath `
                -RepositoryRoot $resolvedRoot `
                -RelativePath $dossierPath

            if (Test-IsInsideRoot -RepositoryRoot $resolvedRoot -FullPath $dossierFullPath) {
                Write-Check "PASS" "CAT-DOSSIER-ROOT" (
                    "Dossier resolves inside repository root: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-DOSSIER-ROOT" (
                    "Dossier resolves outside repository root: {0}" -f $recordLabel
                )
            }

            if (Test-Path -LiteralPath $dossierFullPath -PathType Container) {
                Write-Check "PASS" "CAT-DOSSIER-EXISTS" (
                    "Cataloged dossier directory exists: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-DOSSIER-EXISTS" (
                    "Cataloged dossier directory is missing: {0}" -f $recordLabel
                )
            }

            $dossierName = Split-Path ($dossierPath -replace '/', '\') -Leaf

            if ($dossierName -ceq $recordId) {
                Write-Check "PASS" "CAT-DOSSIER-ID" (
                    "Dossier directory matches the source ID: {0}" -f $recordLabel
                )
            }
            else {
                Write-Check "FAIL" "CAT-DOSSIER-ID" (
                    "Dossier directory must match the source ID: {0}" -f $recordLabel
                )
            }
        }
    }
    }

    if ($parsedColumnsValid) {
        Test-DuplicateColumn -Rows $rows -Column "id" -DuplicateLevel "FAIL"
        Test-DuplicateColumn -Rows $rows -Column "caminho_fonte" -DuplicateLevel "FAIL"
        Test-DuplicateColumn -Rows $rows -Column "checksum_sha256" -DuplicateLevel "WARN"
    }
    else {
        Write-Check "INFO" "CAT-DUP-SKIP" (
            "Duplicate checks skipped because parsed columns are not canonical."
        )
    }

    $sourceIdDirs = @(
        Get-ChildItem -LiteralPath "01-fontes" -Recurse -Directory |
            Where-Object { $_.Name -cmatch '^[A-Z0-9]+(?:-[A-Z0-9]+)+$' } |
            Sort-Object FullName
    )

    Write-Check "INFO" "CAT-COVERAGE-COUNT" (
        "Canonical source-ID directories found: {0}" -f $sourceIdDirs.Count
    )

    if ($parsedColumnsValid) {
        foreach ($sourceIdDir in $sourceIdDirs) {
            $relativeDir = $sourceIdDir.FullName.Substring($resolvedRoot.Length).TrimStart('\', '/')
            $relativeDir = $relativeDir -replace '\\', '/'
            $expectedPrefix = $relativeDir + "/"

            $matchingRows = @(
                $rows |
                    Where-Object {
                        ([string]$_.id -ceq $sourceIdDir.Name) -and
                        (Test-StartsWithOrdinal `
                            -Value ([string]$_.caminho_fonte) `
                            -Prefix $expectedPrefix)
                    }
            )

            if ($matchingRows.Count -gt 0) {
                Write-Check "PASS" "CAT-COVERAGE" (
                    "Source-ID directory is represented in catalog: {0}" -f $relativeDir
                )
            }
            else {
                Write-Check "FAIL" "CAT-COVERAGE" (
                    "Source-ID directory is not represented in catalog: {0}" -f $relativeDir
                )
            }
        }
    }
    else {
        Write-Check "INFO" "CAT-COVERAGE-SKIP" (
            "Coverage checks skipped because parsed columns are not canonical."
        )
    }

    Write-Host ""
    Write-Host "SUMMARY"
    Write-Host ("Checks: {0}" -f $script:CheckCount)
    Write-Host ("Errors: {0}" -f $script:ErrorCount)
    Write-Host ("Warnings: {0}" -f $script:WarningCount)

    if ($script:ErrorCount -eq 0) {
        Write-Host "RESULT: PASS"
        exit 0
    }

    Write-Host "RESULT: FAIL"
    exit 1
}
catch {
    Write-Host ""
    Write-Host ("EXECUTION ERROR: {0}" -f $_.Exception.Message) -ForegroundColor Red
    exit 2
}
