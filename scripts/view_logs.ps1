# View Suricata Logs
# Este script muestra los logs de Suricata IDS

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("alerts", "eve", "fast", "http", "dns", "stats", "live")]
    [string]$LogType = "alerts"
)

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Suricata IDS - Visor de Logs" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Verificar que el contenedor esté corriendo
$suricataRunning = docker ps --filter "name=suricata-ids" --format "{{.Names}}"

if (-not $suricataRunning) {
    Write-Host "✗ El contenedor Suricata no está corriendo." -ForegroundColor Red
    Write-Host "  Ejecute 'start_lab.ps1' primero." -ForegroundColor Yellow
    exit 1
}

switch ($LogType) {
    "alerts" {
        Write-Host "Mostrando alertas de seguridad (eve.json - alerts)..." -ForegroundColor Yellow
        Write-Host "Presione Ctrl+C para salir" -ForegroundColor Gray
        Write-Host ""
        docker exec -it suricata-ids tail -f /var/log/suricata/eve.json | Select-String '"event_type":"alert"'
    }
    "eve" {
        Write-Host "Mostrando todos los eventos (eve.json)..." -ForegroundColor Yellow
        Write-Host "Presione Ctrl+C para salir" -ForegroundColor Gray
        Write-Host ""
        docker exec -it suricata-ids tail -f /var/log/suricata/eve.json
    }
    "fast" {
        Write-Host "Mostrando fast.log..." -ForegroundColor Yellow
        Write-Host "Presione Ctrl+C para salir" -ForegroundColor Gray
        Write-Host ""
        docker exec -it suricata-ids tail -f /var/log/suricata/fast.log
    }
    "http" {
        Write-Host "Mostrando tráfico HTTP..." -ForegroundColor Yellow
        Write-Host "Presione Ctrl+C para salir" -ForegroundColor Gray
        Write-Host ""
        docker exec -it suricata-ids tail -f /var/log/suricata/http.log
    }
    "dns" {
        Write-Host "Mostrando consultas DNS..." -ForegroundColor Yellow
        Write-Host "Presione Ctrl+C para salir" -ForegroundColor Gray
        Write-Host ""
        docker exec -it suricata-ids tail -f /var/log/suricata/dns.log
    }
    "stats" {
        Write-Host "Mostrando estadísticas..." -ForegroundColor Yellow
        Write-Host "Presione Ctrl+C para salir" -ForegroundColor Gray
        Write-Host ""
        docker exec -it suricata-ids tail -f /var/log/suricata/stats.log
    }
    "live" {
        Write-Host "Monitoreando alertas en tiempo real..." -ForegroundColor Yellow
        Write-Host "Presione Ctrl+C para salir" -ForegroundColor Gray
        Write-Host ""
        docker exec -it suricata-ids bash -c "tail -f /var/log/suricata/fast.log | grep --line-buffered -E '\[Classification:|\[Priority:'"
    }
}
