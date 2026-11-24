param(
    [Parameter(Mandatory = $true)]
    [string]$File,
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[A-Fa-f0-9]{64}$')]
    [string]$ExpectedSha256
)

$resolved = Resolve-Path -LiteralPath $File -ErrorAction Stop
$actual = (Get-FileHash -LiteralPath $resolved.Path -Algorithm SHA256).Hash.ToLowerInvariant()
$expected = $ExpectedSha256.ToLowerInvariant()
Write-Output "File: $($resolved.Path)"
Write-Output "SHA-256: $actual"
if ($actual -ne $expected) {
    Write-Error "SHA-256 mismatch. Do not use this image."
    exit 1
}
Write-Output "SHA-256 matches the supplied official value. This does not verify model selection."
