param(
    [string]$Root = (Get-Location).Path,
    [string]$MarkdownPath = ""
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

function Get-RelativeRepositoryPath {
    param(
        [string]$RepositoryRoot,
        [string]$FullPath
    )

    if ($FullPath.Equals($RepositoryRoot, [StringComparison]::OrdinalIgnoreCase)) {
        return "."
    }

    $rootPrefix = $RepositoryRoot.TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
    return $FullPath.Substring($rootPrefix.Length) -replace '\\', '/'
}

function Test-IsInsideRoot {
    param(
        [string]$RepositoryRoot,
        [string]$FullPath
    )

    if ($FullPath.Equals($RepositoryRoot, [StringComparison]::OrdinalIgnoreCase)) {
        return $true
    }

    $rootPrefix = $RepositoryRoot.TrimEnd('\', '/') + [IO.Path]::DirectorySeparatorChar
    return $FullPath.StartsWith($rootPrefix, [StringComparison]::OrdinalIgnoreCase)
}

function Get-AnalysisLine {
    param([string]$Line)

    $result = $Line
    $matches = [regex]::Matches($Line, '`+[^`]*`+')

    foreach ($match in @($matches | Sort-Object Index -Descending)) {
        $spaces = " " * $match.Length
        $result = $result.Remove($match.Index, $match.Length).Insert($match.Index, $spaces)
    }

    return $result
}

function Get-LinkDestination {
    param([string]$RawTarget)

    $value = $RawTarget.Trim()

    if ([string]::IsNullOrWhiteSpace($value)) {
        return ""
    }

    if ($value.StartsWith('<')) {
        $closing = $value.IndexOf('>')

        if ($closing -gt 0) {
            return $value.Substring(1, $closing - 1)
        }
    }

    $match = [regex]::Match(
        $value,
        '^(?<target>\S+?)(?:\s+["''][^"'']*["''])?$'
    )

    if ($match.Success) {
        return $match.Groups['target'].Value
    }

    return $value
}

function Get-TargetKind {
    param([string]$Target)

    if ([string]::IsNullOrWhiteSpace($Target)) {
        return "empty"
    }

    if ($Target.StartsWith('#')) {
        return "fragment"
    }

    if ($Target -match '^(?i)https?://') {
        return "external-http"
    }

    if ($Target -match '^(?i)mailto:') {
        return "mailto"
    }

    if ($Target -match '^(?i)tel:') {
        return "tel"
    }

    if ($Target -match '^[A-Za-z][A-Za-z0-9+.-]*:') {
        return "other-scheme"
    }

    if ($Target -match '^[A-Za-z]:[\\/]') {
        return "windows-absolute"
    }

    if ($Target.StartsWith('/')) {
        return "root-local"
    }

    return "relative-local"
}

function Test-NonPortableTarget {
    param([string]$Target)

    $patterns = @(
        '(?i)filecite',
        '(?i)turn[0-9]+file[0-9]+',
        '(?i)sandbox:/',
        '(?i)attachment://',
        '(?i)file://',
        '^[A-Za-z]:[\\/]'
    )

    foreach ($pattern in $patterns) {
        if ($Target -match $pattern) {
            return $true
        }
    }

    return $false
}

function Split-LocalTarget {
    param([string]$Target)

    $pathPart = $Target
    $fragment = ""

    $hashIndex = $pathPart.IndexOf('#')

    if ($hashIndex -ge 0) {
        $fragment = $pathPart.Substring($hashIndex + 1)
        $pathPart = $pathPart.Substring(0, $hashIndex)
    }

    $queryIndex = $pathPart.IndexOf('?')

    if ($queryIndex -ge 0) {
        $pathPart = $pathPart.Substring(0, $queryIndex)
    }

    try {
        $pathPart = [Uri]::UnescapeDataString($pathPart)
        $fragment = [Uri]::UnescapeDataString($fragment)
    }
    catch {
        # Preserve the original values when percent decoding fails.
    }

    return [pscustomobject]@{
        Path = $pathPart
        Fragment = $fragment
    }
}

function Resolve-LocalTarget {
    param(
        [string]$RepositoryRoot,
        [string]$SourceFile,
        [string]$Target
    )

    $parts = Split-LocalTarget -Target $Target
    $pathPart = $parts.Path

    if ([string]::IsNullOrWhiteSpace($pathPart)) {
        return [pscustomobject]@{
            FullPath = $SourceFile
            Fragment = $parts.Fragment
        }
    }

    $platformPath = $pathPart -replace '/', '\'
    $sourceDirectory = Split-Path -Parent $SourceFile
    $candidate = Join-Path $sourceDirectory $platformPath

    return [pscustomobject]@{
        FullPath = [IO.Path]::GetFullPath($candidate)
        Fragment = $parts.Fragment
    }
}

function Test-PathCaseExact {
    param(
        [string]$RepositoryRoot,
        [string]$FullPath
    )

    if (-not (Test-IsInsideRoot -RepositoryRoot $RepositoryRoot -FullPath $FullPath)) {
        return $false
    }

    if ($FullPath.Equals($RepositoryRoot, [StringComparison]::OrdinalIgnoreCase)) {
        return $true
    }

    $relativePath = Get-RelativeRepositoryPath `
        -RepositoryRoot $RepositoryRoot `
        -FullPath $FullPath

    $segments = @(
        $relativePath -split '/' |
            Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    )

    $current = $RepositoryRoot

    foreach ($segment in $segments) {
        $entries = @(
            Get-ChildItem -LiteralPath $current -Force -ErrorAction Stop |
                Where-Object { $_.Name -ceq $segment }
        )

        if ($entries.Count -ne 1) {
            return $false
        }

        $current = $entries[0].FullName
    }

    return $true
}

function ConvertTo-GitHubSlugBase {
    param([string]$HeadingText)

    $value = $HeadingText

    $value = [regex]::Replace(
        $value,
        '!\[(?<text>[^\]]*)\]\([^)]+\)',
        '${text}'
    )

    $value = [regex]::Replace(
        $value,
        '\[(?<text>[^\]]+)\]\([^)]+\)',
        '${text}'
    )

    $value = [regex]::Replace($value, '<[^>]+>', '')
    $value = $value -replace '[`*_~]', ''
    $value = [System.Net.WebUtility]::HtmlDecode($value)
    $value = $value.ToLowerInvariant()
    $value = [regex]::Replace($value, '[^\p{L}\p{M}\p{N}\s\-_]', '')
    $value = [regex]::Replace($value, '\s+', '-')
    $value = $value.Trim('-')

    return $value
}

function Get-MarkdownAnchors {
    param(
        [string]$FullPath,
        [System.Text.Encoding]$StrictUtf8
    )

    $bytes = [IO.File]::ReadAllBytes($FullPath)
    $content = $StrictUtf8.GetString($bytes)
    $lines = @($content -split "`n")

    $anchors = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
    $slugCounts = @{}
    $insideFence = $false
    $fenceCharacter = ""
    $fenceLength = 0

    for ($index = 0; $index -lt $lines.Count; $index++) {
        $line = $lines[$index].TrimEnd("`r")

        $fenceMatch = [regex]::Match($line, '^\s*(?<fence>`{3,}|~{3,})')

        if ($fenceMatch.Success) {
            $fence = $fenceMatch.Groups['fence'].Value
            $character = $fence.Substring(0, 1)

            if (-not $insideFence) {
                $insideFence = $true
                $fenceCharacter = $character
                $fenceLength = $fence.Length
            }
            elseif (
                $character -eq $fenceCharacter -and
                $fence.Length -ge $fenceLength
            ) {
                $insideFence = $false
                $fenceCharacter = ""
                $fenceLength = 0
            }

            continue
        }

        if ($insideFence) {
            continue
        }

        $analysisLine = Get-AnalysisLine -Line $line

        $explicitMatches = [regex]::Matches(
            $analysisLine,
            '(?i)<(?:a|span|div|section|h[1-6])\b[^>]*\b(?:id|name)\s*=\s*["''](?<id>[^"'']+)["''][^>]*>'
        )

        foreach ($match in $explicitMatches) {
            $null = $anchors.Add($match.Groups['id'].Value)
        }

        $headingText = $null
        $atxMatch = [regex]::Match(
            $analysisLine,
            '^\s{0,3}#{1,6}\s+(?<text>.+?)\s*#*\s*$'
        )

        if ($atxMatch.Success) {
            $headingText = $atxMatch.Groups['text'].Value
        }
        elseif (
            $index + 1 -lt $lines.Count -and
            -not [string]::IsNullOrWhiteSpace($analysisLine)
        ) {
            $underline = $lines[$index + 1].TrimEnd("`r")

            if ($underline -match '^\s{0,3}(=+|-+)\s*$') {
                $headingText = $analysisLine.Trim()
                $index++
            }
        }

        if ($null -ne $headingText) {
            $baseSlug = ConvertTo-GitHubSlugBase -HeadingText $headingText

            if ([string]::IsNullOrWhiteSpace($baseSlug)) {
                continue
            }

            if (-not $slugCounts.ContainsKey($baseSlug)) {
                $slugCounts[$baseSlug] = 0
                $slug = $baseSlug
            }
            else {
                $slugCounts[$baseSlug]++
                $slug = "{0}-{1}" -f $baseSlug, $slugCounts[$baseSlug]
            }

            $null = $anchors.Add($slug)
        }
    }

    return $anchors
}

function Get-MarkdownFiles {
    param(
        [string]$RepositoryRoot,
        [string]$RequestedPath
    )

    if ([string]::IsNullOrWhiteSpace($RequestedPath)) {
        return @(
            git ls-files -- '*.md' |
                Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
                Sort-Object |
                ForEach-Object {
                    Join-Path $RepositoryRoot ($_ -replace '/', '\')
                }
        )
    }

    $requestedFullPath = [IO.Path]::GetFullPath(
        (Join-Path $RepositoryRoot ($RequestedPath -replace '/', '\'))
    )

    if (-not (Test-IsInsideRoot -RepositoryRoot $RepositoryRoot -FullPath $requestedFullPath)) {
        throw "MarkdownPath resolves outside the repository root."
    }

    if (Test-Path -LiteralPath $requestedFullPath -PathType Leaf) {
        if ([IO.Path]::GetExtension($requestedFullPath) -ine ".md") {
            throw "MarkdownPath must identify a Markdown file or directory."
        }

        return @($requestedFullPath)
    }

    if (Test-Path -LiteralPath $requestedFullPath -PathType Container) {
        return @(
            Get-ChildItem `
                -LiteralPath $requestedFullPath `
                -Filter '*.md' `
                -File `
                -Recurse |
                Sort-Object FullName |
                ForEach-Object { $_.FullName }
        )
    }

    throw ("MarkdownPath does not exist: {0}" -f $RequestedPath)
}

try {
    $resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
    Set-Location -LiteralPath $resolvedRoot

    Write-Host ""
    Write-Host "SKF LINK CHECKER v1.0.0" -ForegroundColor Cyan
    Write-Host ("Root: {0}" -f $resolvedRoot)

    if ([string]::IsNullOrWhiteSpace($MarkdownPath)) {
        Write-Host "Scope: tracked Markdown files"
    }
    else {
        Write-Host ("Scope: {0}" -f $MarkdownPath)
    }

    Write-Host ""

    $insideWorkTree = (git rev-parse --is-inside-work-tree 2>$null)

    if ($LASTEXITCODE -ne 0 -or $insideWorkTree.Trim() -ne "true") {
        Write-Check "FAIL" "GIT-001" "The selected root is not a Git working tree."
        throw "Validation cannot continue outside a Git working tree."
    }

    Write-Check "PASS" "GIT-001" "Git working tree detected."

    $markdownFiles = @(
        Get-MarkdownFiles `
            -RepositoryRoot $resolvedRoot `
            -RequestedPath $MarkdownPath
    )

    if ($markdownFiles.Count -eq 0) {
        Write-Check "FAIL" "LINK-CORPUS" "No Markdown files were found in the selected scope."
    }
    else {
        Write-Check "PASS" "LINK-CORPUS" (
            "Markdown files selected: {0}" -f $markdownFiles.Count
        )
    }

    $strictUtf8 = New-Object `
        -TypeName System.Text.UTF8Encoding `
        -ArgumentList @($false, $true)

    $anchorCache = @{}
    $totalLinkTargets = 0
    $totalLocalTargets = 0
    $totalExternalTargets = 0
    $totalReferenceUsages = 0
    $totalNonPortableTargets = 0

    foreach ($fullPath in $markdownFiles) {
        $relativePath = Get-RelativeRepositoryPath `
            -RepositoryRoot $resolvedRoot `
            -FullPath $fullPath

        $bytes = [IO.File]::ReadAllBytes($fullPath)
        $content = $null

        try {
            $content = $strictUtf8.GetString($bytes)
            Write-Check "PASS" "LINK-UTF8" (
                "Markdown file is valid UTF-8: {0}" -f $relativePath
            )
        }
        catch {
            Write-Check "FAIL" "LINK-UTF8" (
                "Markdown file contains invalid UTF-8 bytes: {0}" -f $relativePath
            )
            continue
        }

        $lines = @($content -split "`n")
        $insideFence = $false
        $fenceCharacter = ""
        $fenceLength = 0
        $referenceDefinitions = @{}
        $referenceUsages = New-Object System.Collections.Generic.List[object]
        $targetRecords = New-Object System.Collections.Generic.List[object]
        $unparsedCandidates = New-Object System.Collections.Generic.List[object]

        for ($index = 0; $index -lt $lines.Count; $index++) {
            $lineNumber = $index + 1
            $line = $lines[$index].TrimEnd("`r")

            $fenceMatch = [regex]::Match($line, '^\s*(?<fence>`{3,}|~{3,})')

            if ($fenceMatch.Success) {
                $fence = $fenceMatch.Groups['fence'].Value
                $character = $fence.Substring(0, 1)

                if (-not $insideFence) {
                    $insideFence = $true
                    $fenceCharacter = $character
                    $fenceLength = $fence.Length
                }
                elseif (
                    $character -eq $fenceCharacter -and
                    $fence.Length -ge $fenceLength
                ) {
                    $insideFence = $false
                    $fenceCharacter = ""
                    $fenceLength = 0
                }

                continue
            }

            if ($insideFence) {
                continue
            }

            $analysisLine = Get-AnalysisLine -Line $line

            $definitionMatch = [regex]::Match(
                $analysisLine,
                '^\s*\[(?<label>[^\]]+)\]:\s*(?<target><[^>]+>|\S+(?:\s+["''][^"'']*["''])?)\s*$'
            )

            if ($definitionMatch.Success) {
                $label = $definitionMatch.Groups['label'].Value.Trim().ToLowerInvariant()
                $target = Get-LinkDestination `
                    -RawTarget $definitionMatch.Groups['target'].Value

                if ($referenceDefinitions.ContainsKey($label)) {
                    Write-Check "FAIL" "LINK-REF-DUPLICATE" (
                        "Duplicate reference definition [{0}] in {1}:{2}" -f
                        $label,
                        $relativePath,
                        $lineNumber
                    )
                }
                else {
                    $referenceDefinitions[$label] = [pscustomobject]@{
                        Target = $target
                        Line = $lineNumber
                    }
                }

                $targetRecords.Add(
                    [pscustomobject]@{
                        File = $relativePath
                        FullFile = $fullPath
                        Line = $lineNumber
                        Type = "reference-definition"
                        Target = $target
                    }
                )

                continue
            }

            $inlineMatches = [regex]::Matches(
                $analysisLine,
                '(?<image>!)?\[[^\]]*\]\((?<target><[^>]+>|[^)\s]+(?:\s+["''][^"'']*["''])?)\)'
            )

            foreach ($match in $inlineMatches) {
                $target = Get-LinkDestination -RawTarget $match.Groups['target'].Value
                $type = if ($match.Groups['image'].Success) {
                    "image"
                }
                else {
                    "inline-link"
                }

                $targetRecords.Add(
                    [pscustomobject]@{
                        File = $relativePath
                        FullFile = $fullPath
                        Line = $lineNumber
                        Type = $type
                        Target = $target
                    }
                )
            }

            $candidateCount = [regex]::Matches($analysisLine, '\]\(').Count

            if ($candidateCount -gt $inlineMatches.Count) {
                $unparsedCandidates.Add(
                    [pscustomobject]@{
                        Line = $lineNumber
                        Text = $line.Trim()
                    }
                )
            }

            $referenceMatches = [regex]::Matches(
                $analysisLine,
                '(?<image>!)?\[(?<text>[^\]]+)\]\[(?<label>[^\]]*)\]'
            )

            foreach ($match in $referenceMatches) {
                $label = $match.Groups['label'].Value.Trim()

                if ([string]::IsNullOrWhiteSpace($label)) {
                    $label = $match.Groups['text'].Value.Trim()
                }

                $referenceUsages.Add(
                    [pscustomobject]@{
                        Label = $label.ToLowerInvariant()
                        Line = $lineNumber
                    }
                )

                $totalReferenceUsages++
            }

            $remainingLine = $analysisLine

            foreach ($match in @($inlineMatches | Sort-Object Index -Descending)) {
                $spaces = " " * $match.Length
                $remainingLine = $remainingLine.Remove(
                    $match.Index,
                    $match.Length
                ).Insert(
                    $match.Index,
                    $spaces
                )
            }

            $autolinkMatches = [regex]::Matches(
                $remainingLine,
                '<(?<target>https?://[^>\s]+|mailto:[^>\s]+|tel:[^>\s]+)>'
            )

            foreach ($match in $autolinkMatches) {
                $targetRecords.Add(
                    [pscustomobject]@{
                        File = $relativePath
                        FullFile = $fullPath
                        Line = $lineNumber
                        Type = "autolink"
                        Target = $match.Groups['target'].Value
                    }
                )
            }

            foreach ($match in @($autolinkMatches | Sort-Object Index -Descending)) {
                $spaces = " " * $match.Length
                $remainingLine = $remainingLine.Remove(
                    $match.Index,
                    $match.Length
                ).Insert(
                    $match.Index,
                    $spaces
                )
            }

            $rawUrlMatches = [regex]::Matches(
                $remainingLine,
                '(?i)(?<!["''(<])https?://[^\s<>)\]]+'
            )

            foreach ($match in $rawUrlMatches) {
                $targetRecords.Add(
                    [pscustomobject]@{
                        File = $relativePath
                        FullFile = $fullPath
                        Line = $lineNumber
                        Type = "raw-url"
                        Target = $match.Value.TrimEnd('.', ',', ';', ':')
                    }
                )
            }
        }

        if ($insideFence) {
            Write-Check "FAIL" "LINK-FENCE" (
                "Unclosed fenced code block: {0}" -f $relativePath
            )
        }

        foreach ($candidate in $unparsedCandidates) {
            Write-Check "FAIL" "LINK-PARSE" (
                "Unparsed Markdown link candidate in {0}:{1}: {2}" -f
                $relativePath,
                $candidate.Line,
                $candidate.Text
            )
        }

        foreach ($usage in $referenceUsages) {
            if (-not $referenceDefinitions.ContainsKey($usage.Label)) {
                Write-Check "FAIL" "LINK-REF-UNRESOLVED" (
                    "Unresolved reference [{0}] in {1}:{2}" -f
                    $usage.Label,
                    $relativePath,
                    $usage.Line
                )
            }
        }

        foreach ($record in $targetRecords) {
            $totalLinkTargets++
            $target = [string]$record.Target
            $kind = Get-TargetKind -Target $target
            $location = "{0}:{1}" -f $record.File, $record.Line

            if (Test-NonPortableTarget -Target $target) {
                $totalNonPortableTargets++
                Write-Check "FAIL" "LINK-NONPORTABLE" (
                    "Non-portable link target in {0}: {1}" -f
                    $location,
                    $target
                )
                continue
            }

            switch ($kind) {
                "empty" {
                    Write-Check "FAIL" "LINK-TARGET-EMPTY" (
                        "Empty link target in {0}" -f $location
                    )
                }

                "root-local" {
                    Write-Check "FAIL" "LINK-ROOT-LOCAL" (
                        "Root-relative link is not repository-portable in {0}: {1}" -f
                        $location,
                        $target
                    )
                }

                "windows-absolute" {
                    Write-Check "FAIL" "LINK-NONPORTABLE" (
                        "Absolute Windows path in {0}: {1}" -f
                        $location,
                        $target
                    )
                }

                "other-scheme" {
                    Write-Check "FAIL" "LINK-SCHEME" (
                        "Unsupported URI scheme in {0}: {1}" -f
                        $location,
                        $target
                    )
                }

                "external-http" {
                    $uri = $null
                    $created = [Uri]::TryCreate(
                        $target,
                        [UriKind]::Absolute,
                        [ref]$uri
                    )

                    if (-not $created) {
                        Write-Check "FAIL" "LINK-EXTERNAL-URI" (
                            "Invalid external URI in {0}: {1}" -f
                            $location,
                            $target
                        )
                    }
                    else {
                        $totalExternalTargets++
                        Write-Check "PASS" "LINK-EXTERNAL-URI" (
                            "External URI is syntactically valid in {0}: {1}" -f
                            $location,
                            $target
                        )
                    }
                }

                "mailto" {
                    $address = $target.Substring(7)

                    if (
                        [string]::IsNullOrWhiteSpace($address) -or
                        $address -notmatch '^[^@\s]+@[^@\s]+$'
                    ) {
                        Write-Check "FAIL" "LINK-MAILTO" (
                            "Invalid mailto target in {0}: {1}" -f
                            $location,
                            $target
                        )
                    }
                    else {
                        Write-Check "PASS" "LINK-MAILTO" (
                            "Valid mailto target in {0}: {1}" -f
                            $location,
                            $target
                        )
                    }
                }

                "tel" {
                    $number = $target.Substring(4)

                    if ($number -notmatch '^\+?[0-9().\-\s]+$') {
                        Write-Check "FAIL" "LINK-TEL" (
                            "Invalid tel target in {0}: {1}" -f
                            $location,
                            $target
                        )
                    }
                    else {
                        Write-Check "PASS" "LINK-TEL" (
                            "Valid tel target in {0}: {1}" -f
                            $location,
                            $target
                        )
                    }
                }

                { $_ -eq "fragment" -or $_ -eq "relative-local" } {
                    $totalLocalTargets++
                    $resolved = Resolve-LocalTarget `
                        -RepositoryRoot $resolvedRoot `
                        -SourceFile $record.FullFile `
                        -Target $target

                    if (
                        -not (
                            Test-IsInsideRoot `
                                -RepositoryRoot $resolvedRoot `
                                -FullPath $resolved.FullPath
                        )
                    ) {
                        Write-Check "FAIL" "LINK-LOCAL-ROOT" (
                            "Local target resolves outside repository root in {0}: {1}" -f
                            $location,
                            $target
                        )
                        continue
                    }

                    if (-not (Test-Path -LiteralPath $resolved.FullPath)) {
                        Write-Check "FAIL" "LINK-LOCAL-EXISTS" (
                            "Local target does not exist in {0}: {1}" -f
                            $location,
                            $target
                        )
                        continue
                    }

                    if (
                        -not (
                            Test-PathCaseExact `
                                -RepositoryRoot $resolvedRoot `
                                -FullPath $resolved.FullPath
                        )
                    ) {
                        Write-Check "FAIL" "LINK-LOCAL-CASE" (
                            "Local target casing is not exact in {0}: {1}" -f
                            $location,
                            $target
                        )
                        continue
                    }

                    Write-Check "PASS" "LINK-LOCAL-EXISTS" (
                        "Local target exists with exact casing in {0}: {1}" -f
                        $location,
                        $target
                    )

                    if (-not [string]::IsNullOrWhiteSpace($resolved.Fragment)) {
                        if (
                            -not (
                                Test-Path `
                                    -LiteralPath $resolved.FullPath `
                                    -PathType Leaf
                            ) -or
                            [IO.Path]::GetExtension($resolved.FullPath) -ine ".md"
                        ) {
                            Write-Check "FAIL" "LINK-ANCHOR-TYPE" (
                                "Fragment target is not a Markdown file in {0}: {1}" -f
                                $location,
                                $target
                            )
                            continue
                        }

                        $cacheKey = $resolved.FullPath.ToLowerInvariant()

                        if (-not $anchorCache.ContainsKey($cacheKey)) {
                            $anchorCache[$cacheKey] = Get-MarkdownAnchors `
                                -FullPath $resolved.FullPath `
                                -StrictUtf8 $strictUtf8
                        }

                        $anchors = $anchorCache[$cacheKey]

                        if ($anchors.Contains($resolved.Fragment)) {
                            Write-Check "PASS" "LINK-ANCHOR" (
                                "Fragment exists in {0}: #{1}" -f
                                $location,
                                $resolved.Fragment
                            )
                        }
                        else {
                            Write-Check "FAIL" "LINK-ANCHOR" (
                                "Fragment does not exist in {0}: #{1}" -f
                                $location,
                                $resolved.Fragment
                            )
                        }
                    }
                }
            }
        }
    }

    if ($totalExternalTargets -gt 0) {
        Write-Check "INFO" "LINK-EXTERNAL-NETWORK" (
            "External network reachability is not checked in deterministic mode."
        )
    }

    Write-Host ""
    Write-Host "SUMMARY"
    Write-Host ("Markdown files: {0}" -f $markdownFiles.Count)
    Write-Host ("Link targets: {0}" -f $totalLinkTargets)
    Write-Host ("Local targets: {0}" -f $totalLocalTargets)
    Write-Host ("External HTTP(S) targets: {0}" -f $totalExternalTargets)
    Write-Host ("Reference usages: {0}" -f $totalReferenceUsages)
    Write-Host ("Non-portable targets: {0}" -f $totalNonPortableTargets)
    Write-Host ("Checks: {0}" -f $script:CheckCount)
    Write-Host ("Errors: {0}" -f $script:ErrorCount)
    Write-Host ("Warnings: {0}" -f $script:WarningCount)

    if ($script:ErrorCount -gt 0) {
        Write-Host "RESULT: FAIL"
        exit 1
    }

    Write-Host "RESULT: PASS"
    exit 0
}
catch {
    Write-Host ("LINK CHECKER ERROR: {0}" -f $_.Exception.Message) -ForegroundColor Red
    exit 2
}
