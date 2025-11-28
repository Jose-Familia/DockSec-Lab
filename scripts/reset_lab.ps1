# Reset Docker Security Lab Environment
# Este script reinicia completamente el laboratorio eliminando todos los datos

Write-Host "==================================================" -ForegroundColor Red
Write-Host "  Docker Security Lab - Reiniciar Laboratorio" -ForegroundColor Red
Write-Host "==================================================" -ForegroundColor Red
Write-Host ""
Write-Host "ADVERTENCIA: Esto eliminará todos los contenedores," -ForegroundColor Yellow
Write-Host "volúmenes y datos del laboratorio." -ForegroundColor Yellow
Write-Host ""

$confirmation = Read-Host "¿Está seguro? (s/N)"
if ($confirmation -ne 's' -and $confirmation -ne 'S') {
    Write-Host "Operación cancelada." -ForegroundColor Yellow
    exit 0
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

Set-Location $projectRoot

Write-Host ""
Write-Host "Deteniendo y eliminando contenedores..." -ForegroundColor Yellow
docker-compose -f compose/docker-compose.monitor.yml down -v --remove-orphans
docker-compose -f compose/docker-compose.lab.yml down -v --remove-orphans

Write-Host ""
Write-Host "Limpiando recursos..." -ForegroundColor Yellow
docker system prune -f

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  Laboratorio reiniciado!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Ejecute 'start_lab.ps1' para iniciar nuevamente." -ForegroundColor Cyan
