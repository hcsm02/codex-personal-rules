[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path

function Invoke-Git {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments
    )

    & git -C $repoRoot @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') failed with exit code $LASTEXITCODE"
    }
}

function Get-UpstreamRef {
    try {
        $upstream = (& git -C $repoRoot rev-parse --abbrev-ref --symbolic-full-name "@{u}").Trim()
        if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($upstream)) {
            throw "missing upstream"
        }
        return $upstream
    }
    catch {
        throw "The repository does not have an upstream branch configured."
    }
}

function Get-AheadBehind {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Upstream
    )

    $counts = (& git -C $repoRoot rev-list --left-right --count "$Upstream...HEAD").Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to compare HEAD with $Upstream."
    }

    $parts = $counts -split "\s+"
    if ($parts.Count -ne 2) {
        throw "Unexpected rev-list output: $counts"
    }

    [pscustomobject]@{
        Behind = [int]$parts[0]
        Ahead  = [int]$parts[1]
    }
}

$status = (& git -C $repoRoot status --porcelain=v1).Trim()
if ($LASTEXITCODE -ne 0) {
    throw "Failed to inspect repository status."
}

if ($status) {
    Write-Host "Skip sync: working tree is dirty in $repoRoot"
    exit 2
}

$upstream = Get-UpstreamRef

Write-Host "Fetching origin for $repoRoot"
Invoke-Git -Arguments @("fetch", "--prune", "origin")

$counts = Get-AheadBehind -Upstream $upstream

if ($counts.Behind -gt 0 -and $counts.Ahead -gt 0) {
    Write-Host "Skip sync: local branch diverged from $upstream. Resolve manually."
    exit 3
}

if ($counts.Behind -gt 0) {
    Write-Host "Fast-forwarding local branch from $upstream"
    Invoke-Git -Arguments @("pull", "--ff-only")
}

$counts = Get-AheadBehind -Upstream $upstream

if ($counts.Behind -gt 0 -and $counts.Ahead -gt 0) {
    Write-Host "Skip sync: branch diverged after pull attempt. Resolve manually."
    exit 3
}

if ($counts.Ahead -gt 0) {
    Write-Host "Pushing local commits to $upstream"
    Invoke-Git -Arguments @("push")
    exit 0
}

Write-Host "Repo already in sync with $upstream"
exit 0
