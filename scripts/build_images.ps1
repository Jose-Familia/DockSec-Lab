# Build Docker Images for Security Lab
# Este script construye las imágenes personalizadas de Docker

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Docker Security Lab - Build Images" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

Set-Location $projectRoot

Write-Host "[1/2] Construyendo imagen Kali Linux..." -ForegroundColor Yellow
docker build -t lab/kali:1.0 -f dockerfiles/Dockerfile.kali .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Imagen Kali construida exitosamente" -ForegroundColor Green
} else {
    Write-Host "✗ Error construyendo imagen Kali" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2/2] Construyendo imagen Suricata IDS..." -ForegroundColor Yellow
docker build -t lab/suricata:1.0 -f dockerfiles/Dockerfile.suricata .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Imagen Suricata construida exitosamente" -ForegroundColor Green
} else {
    Write-Host "✗ Error construyendo imagen Suricata" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  Todas las imágenes construidas exitosamente!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Imágenes disponibles:" -ForegroundColor Cyan
docker images | Select-String "lab/"
