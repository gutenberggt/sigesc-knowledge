param(
    [string]$Root = (Get-Location).Path
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

function Get-RelativePath {
    param(
        [string]$BasePath,
        [string]$FullPath
    )

    return $FullPath.Substring($BasePath.Length).TrimStart('\', '/')
}

try {
    $resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
    Set-Location -LiteralPath $resolvedRoot

    Write-Host ""
    Write-Host "SKF STRUCTURE VALIDATOR v1.0.0" -ForegroundColor Cyan
    Write-Host ("Root: {0}" -f $resolvedRoot)
    Write-Host ""

    if (-not (Test-Path -LiteralPath ".git" -PathType Container)) {
        Write-Check "FAIL" "GIT-001" "The selected root is not a Git working tree."
        throw "Validation cannot continue outside a Git working tree."
    }

    Write-Check "PASS" "GIT-001" "Git working tree detected."

    $requiredRootFiles = @(
        "README.md",
        "knowledge-index.md",
        "catalogo.csv",
        "LICENSE",
        "NOTICE.md",
        ".gitignore",
        ".gitattributes"
    )

    $requiredRootDirs = @(
        "00-governance",
        "01-fontes",
        "02-dossies",
        "03-conhecimento-consolidado",
        "04-rastreabilidade",
        "05-evidencias",
        "06-automacao",
        "98-entrada",
        "99-arquivo"
    )

    $canonicalTopLevel = @($requiredRootFiles + $requiredRootDirs)

    foreach ($path in $requiredRootFiles) {
        if (Test-Path -LiteralPath $path -PathType Leaf) {
            Write-Check "PASS" "ROOT-FILE" ("Required file exists: {0}" -f $path)
        }
        else {
            Write-Check "FAIL" "ROOT-FILE" ("Required file is missing: {0}" -f $path)
        }
    }

    foreach ($path in $requiredRootDirs) {
        if (Test-Path -LiteralPath $path -PathType Container) {
            Write-Check "PASS" "ROOT-DIR" ("Required directory exists: {0}" -f $path)
        }
        else {
            Write-Check "FAIL" "ROOT-DIR" ("Required directory is missing: {0}" -f $path)
        }
    }

    $actualTopLevel = @(
        Get-ChildItem -Force |
            Where-Object { $_.Name -ne ".git" } |
            Sort-Object Name
    )

    $unexpectedTopLevel = @(
        $actualTopLevel |
            Where-Object { $canonicalTopLevel -notcontains $_.Name }
    )

    if ($unexpectedTopLevel.Count -eq 0) {
        Write-Check "PASS" "ROOT-SCOPE" "No unexpected top-level entries were found."
    }
    else {
        foreach ($entry in $unexpectedTopLevel) {
            Write-Check "FAIL" "ROOT-SCOPE" ("Unexpected top-level entry: {0}" -f $entry.Name)
        }
    }

    foreach ($dir in $requiredRootDirs) {
        $readmePath = Join-Path $dir "README.md"

        if (Test-Path -LiteralPath $readmePath -PathType Leaf) {
            Write-Check "PASS" "LAYER-README" ("Layer README exists: {0}" -f $readmePath)
        }
        else {
            Write-Check "FAIL" "LAYER-README" ("Layer README is missing: {0}" -f $readmePath)
        }
    }

    $dossierRoot = "02-dossies"
    $dossierDirs = @()

    if (Test-Path -LiteralPath $dossierRoot -PathType Container) {
        $dossierDirs = @(
            Get-ChildItem -LiteralPath $dossierRoot -Directory |
                Sort-Object Name
        )
    }

    Write-Check "INFO" "DOSSIER-COUNT" ("Dossier directories found: {0}" -f $dossierDirs.Count)

    foreach ($dir in $dossierDirs) {
        if ($dir.Name -cmatch '^[A-Z0-9]+(?:-[A-Z0-9]+)+$') {
            Write-Check "PASS" "DOSSIER-ID" ("Canonical dossier directory name: {0}" -f $dir.Name)
        }
        else {
            Write-Check "FAIL" "DOSSIER-ID" ("Invalid dossier directory name: {0}" -f $dir.Name)
        }

        $dossierReadme = Join-Path $dir.FullName "README.md"

        if (Test-Path -LiteralPath $dossierReadme -PathType Leaf) {
            Write-Check "PASS" "DOSSIER-README" ("Dossier README exists: {0}" -f $dir.Name)
        }
        else {
            Write-Check "FAIL" "DOSSIER-README" ("Dossier README is missing: {0}" -f $dir.Name)
        }

        $numberedMarkdown = @(
            Get-ChildItem -LiteralPath $dir.FullName -File |
                Where-Object { $_.Name -cmatch '^([0-9]{2})-[a-z0-9]+(?:-[a-z0-9]+)*\.md$' } |
                Sort-Object Name
        )

        if ($numberedMarkdown.Count -eq 0) {
            Write-Check "WARN" "DOSSIER-SEQUENCE" ("No numbered Markdown artifacts found: {0}" -f $dir.Name)
            continue
        }

        $numbers = @(
            $numberedMarkdown |
                ForEach-Object {
                    if ($_.Name -cmatch '^([0-9]{2})-') {
                        [int]$Matches[1]
                    }
                } |
                Sort-Object
        )

        $duplicateGroups = @(
            $numbers |
                Group-Object |
                Where-Object { $_.Count -gt 1 }
        )

        if ($duplicateGroups.Count -eq 0) {
            Write-Check "PASS" "DOSSIER-DUPLICATE" ("No duplicate numeric prefixes: {0}" -f $dir.Name)
        }
        else {
            foreach ($group in $duplicateGroups) {
                Write-Check "FAIL" "DOSSIER-DUPLICATE" (
                    "Duplicate numeric prefix {0} in dossier {1}" -f $group.Name, $dir.Name
                )
            }
        }

        if ($numbers[0] -eq 0) {
            Write-Check "PASS" "DOSSIER-START" ("Numbered sequence starts at 00: {0}" -f $dir.Name)
        }
        else {
            Write-Check "FAIL" "DOSSIER-START" (
                "Numbered sequence must start at 00; found {0:D2}: {1}" -f $numbers[0], $dir.Name
            )
        }

        $expectedNumbers = @(0..$numbers[$numbers.Count - 1])
        $gaps = @(
            $expectedNumbers |
                Where-Object { $numbers -notcontains $_ }
        )

        if ($gaps.Count -eq 0) {
            Write-Check "PASS" "DOSSIER-GAPS" (
                "Numbered sequence is contiguous from 00 to {0:D2}: {1}" -f
                $numbers[$numbers.Count - 1],
                $dir.Name
            )
        }
        else {
            Write-Check "FAIL" "DOSSIER-GAPS" (
                "Sequence gaps in dossier {0}: {1}" -f
                $dir.Name,
                (($gaps | ForEach-Object { "{0:D2}" -f $_ }) -join ", ")
            )
        }
    }

    $sourceIdDirs = @()

    if (Test-Path -LiteralPath "01-fontes" -PathType Container) {
        $sourceIdDirs = @(
            Get-ChildItem -LiteralPath "01-fontes" -Directory -Recurse |
                Where-Object { $_.Name -cmatch '^[A-Z0-9]+(?:-[A-Z0-9]+)+$' } |
                Sort-Object FullName
        )
    }

    Write-Check "INFO" "SOURCE-ID-COUNT" (
        "Canonical source-ID directories found: {0}" -f $sourceIdDirs.Count
    )

    foreach ($dir in $sourceIdDirs) {
        $relative = Get-RelativePath $resolvedRoot $dir.FullName
        $sourceFiles = @(
            Get-ChildItem -LiteralPath $dir.FullName -File -Recurse
        )

        if ($sourceFiles.Count -gt 0) {
            Write-Check "PASS" "SOURCE-ID-CONTENT" (
                "Source-ID directory contains files: {0}" -f $relative
            )
        }
        else {
            Write-Check "WARN" "SOURCE-ID-CONTENT" (
                "Source-ID directory contains no files: {0}" -f $relative
            )
        }
    }

    $trackedPaths = @(git ls-files)

    $pathsWithSpaces = @(
        $trackedPaths |
            Where-Object { $_ -match ' ' }
    )

    if ($pathsWithSpaces.Count -eq 0) {
        Write-Check "PASS" "PATH-SPACES" "No tracked path contains spaces."
    }
    else {
        foreach ($path in $pathsWithSpaces) {
            Write-Check "FAIL" "PATH-SPACES" ("Tracked path contains spaces: {0}" -f $path)
        }
    }

    $pathsWithNonAscii = @(
        $trackedPaths |
            Where-Object { [regex]::IsMatch($_, '[^\x00-\x7F]') }
    )

    if ($pathsWithNonAscii.Count -eq 0) {
        Write-Check "PASS" "PATH-ASCII" "All tracked paths use ASCII characters."
    }
    else {
        foreach ($path in $pathsWithNonAscii) {
            Write-Check "FAIL" "PATH-ASCII" ("Tracked path contains non-ASCII characters: {0}" -f $path)
        }
    }

    $genericDirectoryNames = @("diversos", "temporario", "outros")
    $genericPathFindings = @()

    foreach ($path in $trackedPaths) {
        $segments = @($path -split '/')

        if ($segments.Count -le 1) {
            continue
        }

        $directorySegments = @($segments[0..($segments.Count - 2)])

        foreach ($segment in $directorySegments) {
            if ($genericDirectoryNames -ccontains $segment) {
                $genericPathFindings += $path
                break
            }
        }
    }

    $genericPathFindings = @($genericPathFindings | Sort-Object -Unique)

    if ($genericPathFindings.Count -eq 0) {
        Write-Check "PASS" "PATH-GENERIC" "No tracked path uses prohibited generic directory names."
    }
    else {
        foreach ($path in $genericPathFindings) {
            Write-Check "FAIL" "PATH-GENERIC" (
                "Tracked path uses a prohibited generic directory: {0}" -f $path
            )
        }
    }

    Write-Host ""
    Write-Host "SUMMARY" -ForegroundColor Cyan
    Write-Host ("Checks: {0}" -f $script:CheckCount)
    Write-Host ("Errors: {0}" -f $script:ErrorCount)
    Write-Host ("Warnings: {0}" -f $script:WarningCount)

    if ($script:ErrorCount -eq 0) {
        Write-Host "RESULT: PASS" -ForegroundColor Green
        exit 0
    }

    Write-Host "RESULT: FAIL" -ForegroundColor Red
    exit 1
}
catch {
    Write-Host ""
    Write-Host ("EXECUTION ERROR: {0}" -f $_.Exception.Message) -ForegroundColor Red
    exit 2
}
