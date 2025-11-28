# Start Docker Security Lab Environment
# Este script inicia el entorno de laboratorio completo

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Docker Security Lab - Iniciar Laboratorio" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$composePath = Join-Path $projectRoot "compose"

Set-Location $projectRoot

# Verificar que las imágenes personalizadas existan
Write-Host "Verificando imágenes..." -ForegroundColor Yellow
$kaliImage = docker images -q lab/kali:1.0
$suricataImage = docker images -q lab/suricata:1.0

if (-not $kaliImage -or -not $suricataImage) {
    Write-Host "✗ Imágenes personalizadas no encontradas. Construyéndolas..." -ForegroundColor Red
    & "$scriptDir\build_images.ps1"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ Error construyendo imágenes" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✓ Imágenes verificadas" -ForegroundColor Green
Write-Host ""

# Iniciar laboratorio
Write-Host "[1/2] Iniciando entorno de laboratorio..." -ForegroundColor Yellow
docker-compose -f compose/docker-compose.lab.yml up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Laboratorio iniciado" -ForegroundColor Green
} else {
    Write-Host "✗ Error iniciando laboratorio" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[2/2] Iniciando sistema de monitoreo..." -ForegroundColor Yellow
docker-compose -f compose/docker-compose.monitor.yml up -d

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Monitoreo iniciado" -ForegroundColor Green
} else {
    Write-Host "✗ Error iniciando monitoreo" -ForegroundColor Red
}

Write-Host ""
Write-Host "==================================================" -ForegroundColor Green
Write-Host "  Laboratorio iniciado exitosamente!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Servicios disponibles:" -ForegroundColor Cyan
Write-Host "  • Juice Shop:        http://localhost:3001" -ForegroundColor White
Write-Host "  • DVWA:              http://localhost:8080" -ForegroundColor White
Write-Host "  • SSH Vulnerable:    localhost:2222 (usuario: admin, contraseña: password123)" -ForegroundColor White
Write-Host "  • Grafana:           http://localhost:3000 (admin/admin)" -ForegroundColor White
Write-Host "  • Prometheus:        http://localhost:9090" -ForegroundColor White
Write-Host "  • cAdvisor:          http://localhost:8081" -ForegroundColor White
Write-Host ""
Write-Host "Contenedores activos:" -ForegroundColor Cyan
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
