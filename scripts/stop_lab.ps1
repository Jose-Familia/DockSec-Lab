# Stop Docker Security Lab Environment
# Este script detiene el entorno de laboratorio

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Docker Security Lab - Detener Laboratorio" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

Set-Location $projectRoot

Write-Host "[1/2] Deteniendo sistema de monitoreo..." -ForegroundColor Yellow
docker-compose -f compose/docker-compose.monitor.yml down

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Monitoreo detenido" -ForegroundColor Green
} else {
    Write-Host "✗ Error deteniendo monitoreo" -ForegroundColor Red
}

Write-Host ""
Write-Host "[2/2] Deteniendo entorno de laboratorio..." -ForegroundColor Yellow
docker-compose -f compose/docker-compose.lab.yml down

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Laboratorio detenido" -ForegroundColor Green
} else {
    Write-Host "✗ Error deteniendo laboratorio" -ForegroundColor Red
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  Laboratorio detenido exitosamente!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
