param(
    [Parameter(Mandatory = $true)]
    [int]$Port
)

if ($Port -lt 1 -or $Port -gt 65535) {
    Write-Host "Error: el puerto debe estar entre 1 y 65535."
    exit 1
}

$result = Test-NetConnection `
    -ComputerName "localhost" `
    -Port $Port `
    -WarningAction SilentlyContinue

if ($result.TcpTestSucceeded) {
    Write-Host "Puerto $Port : ABIERTO"
}
else {
    Write-Host "Puerto $Port : CERRADO"
}
