# Check Docker Security Lab Status
# Este script verifica el estado del laboratorio

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "  Docker Security Lab - Estado del Sistema" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Verificar imágenes
Write-Host "Imágenes personalizadas:" -ForegroundColor Yellow
$kaliImage = docker images -q lab/kali:1.0
$suricataImage = docker images -q lab/suricata:1.0

if ($kaliImage) {
    Write-Host "  ✓ lab/kali:1.0" -ForegroundColor Green
} else {
    Write-Host "  ✗ lab/kali:1.0 (no encontrada)" -ForegroundColor Red
}

if ($suricataImage) {
    Write-Host "  ✓ lab/suricata:1.0" -ForegroundColor Green
} else {
    Write-Host "  ✗ lab/suricata:1.0 (no encontrada)" -ForegroundColor Red
}

Write-Host ""
Write-Host "Contenedores activos:" -ForegroundColor Yellow
$containers = docker ps --format "{{.Names}}" | Where-Object { 
    $_ -match "kali|juice|dvwa|mysql|ssh|suricata|grafana|prometheus|cadvisor" 
}

if ($containers) {
    docker ps --filter "name=kali" --filter "name=juice" --filter "name=dvwa" `
              --filter "name=mysql" --filter "name=ssh" --filter "name=suricata" `
              --filter "name=grafana" --filter "name=prometheus" --filter "name=cadvisor" `
              --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
} else {
    Write-Host "  No hay contenedores activos" -ForegroundColor Red
}

Write-Host ""
Write-Host "Redes:" -ForegroundColor Yellow
docker network ls | Select-String "lab_internal|attacker_net|monitor_net"

Write-Host ""
Write-Host "Volúmenes:" -ForegroundColor Yellow
docker volume ls | Select-String "attacker_home|mysql_data|suricata_logs|grafana_data|prometheus_data"

Write-Host ""
Write-Host "Uso de recursos:" -ForegroundColor Yellow
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}" | Select-Object -First 20

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
