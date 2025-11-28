# Access Kali Linux Container
# Este script proporciona acceso interactivo al contenedor Kali

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Accediendo a Kali Linux Attacker" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Usuario: attacker" -ForegroundColor Yellow
Write-Host "Para ejecutar comandos con sudo: sudo <comando>" -ForegroundColor Yellow
Write-Host ""

# Verificar que el contenedor esté corriendo
$kaliRunning = docker ps --filter "name=kali-attacker" --format "{{.Names}}"

if (-not $kaliRunning) {
    Write-Host "✗ El contenedor Kali no está corriendo." -ForegroundColor Red
    Write-Host "  Ejecute 'start_lab.ps1' primero." -ForegroundColor Yellow
    exit 1
}

# Acceder al contenedor
docker exec -it kali-attacker /bin/bash
