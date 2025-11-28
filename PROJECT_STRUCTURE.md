# 📁 Estructura del Proyecto - Docker Security Lab

```
Docker_Security_lab/
│
├── 📄 README.md                    # Documentación completa del proyecto
├── 📄 QUICK_START.md               # Guía de inicio rápido
├── 📄 .gitignore                   # Archivos excluidos del control de versiones
│
├── 📂 compose/                     # Archivos Docker Compose
│   ├── docker-compose.lab.yml     # Configuración del entorno de laboratorio
│   └── docker-compose.monitor.yml # Configuración del sistema de monitoreo
│
├── 📂 configs/                     # Archivos de configuración
│   ├── filebeat.yml               # Configuración de Filebeat (log collection)
│   ├── prometheus.yml             # Configuración de Prometheus
│   ├── suricata-rules.rules       # Reglas personalizadas de Suricata IDS
│   └── suricata.yaml              # Configuración principal de Suricata
│
├── 📂 dockerfiles/                 # Dockerfiles personalizados
│   ├── Dockerfile.kali            # Imagen de Kali Linux con herramientas
│   └── Dockerfile.suricata        # Imagen de Suricata IDS
│
└── 📂 scripts/                     # Scripts de gestión (PowerShell)
    ├── access_kali.ps1            # Acceder al contenedor Kali
    ├── build_images.ps1           # Construir imágenes personalizadas
    ├── build_images.sh            # Script bash (legacy)
    ├── reset_lab.ps1              # Reiniciar laboratorio completo
    ├── reset_lab.sh               # Script bash (legacy)
    ├── start_lab.ps1              # Iniciar el laboratorio
    ├── status_lab.ps1             # Ver estado del sistema
    ├── stop_lab.ps1               # Detener el laboratorio
    └── view_logs.ps1              # Ver logs de Suricata
```

## 📋 Descripción de Componentes

### Archivos de Documentación

- **README.md**: Documentación completa con instalación, uso, escenarios de práctica y troubleshooting
- **QUICK_START.md**: Referencia rápida para comandos comunes y ataques básicos
- **.gitignore**: Previene commit de logs, datos temporales y secretos

### Docker Compose

#### docker-compose.lab.yml

Orquesta el entorno principal del laboratorio:

- **Redes**: 3 redes aisladas (attacker_net, lab_internal, monitor_net)
- **Servicios**:
  - `kali-attacker`: Máquina atacante con Kali Linux
  - `juice-shop`: OWASP Juice Shop (vulnerable web app)
  - `dvwa`: Damn Vulnerable Web Application
  - `mysql`: Base de datos para DVWA
  - `vuln-ssh`: Servidor SSH vulnerable
  - `suricata`: Sistema de Detección de Intrusiones

#### docker-compose.monitor.yml

Sistema de monitoreo y métricas:

- `prometheus`: Recolección de métricas
- `grafana`: Visualización de datos
- `cadvisor`: Métricas de contenedores Docker

### Configuraciones

#### suricata.yaml

- Configuración completa del IDS
- Definición de redes HOME_NET y EXTERNAL_NET
- Configuración de outputs (eve.json, fast.log, http.log, etc.)
- Configuración de protocolos (HTTP, DNS, TLS, SSH)
- Parámetros de performance

#### suricata-rules.rules

Más de 40 reglas personalizadas organizadas en categorías:

- SQL Injection Detection
- XSS Detection
- Port Scanning Detection
- Brute Force Detection
- Command Injection Detection
- Directory Traversal Detection
- Exploitation Tools Detection
- Protocol Anomalies

#### prometheus.yml

- Jobs de scraping para prometheus, cadvisor
- Configuración de retención de datos
- Métricas de contenedores

#### filebeat.yml

- Recolección de logs de Suricata
- Procesadores para enriquecer datos
- Configuración de outputs

### Dockerfiles

#### Dockerfile.kali

Imagen basada en `kalilinux/kali-rolling`:

- Herramientas preinstaladas: nmap, sqlmap, gobuster, nikto, tcpdump, curl, wget
- Usuario no-root: `attacker` (password: attacker)
- Python 3 con pip

#### Dockerfile.suricata

Imagen basada en `ubuntu:22.04`:

- Suricata IDS instalado
- Configuración y reglas personalizadas
- Logs en `/var/log/suricata/`

### Scripts de Gestión (PowerShell)

Todos los scripts están optimizados para Windows PowerShell:

#### build_images.ps1

- Construye las imágenes personalizadas (Kali y Suricata)
- Verifica éxito de cada build
- Muestra imágenes disponibles al final

#### start_lab.ps1

- Verifica existencia de imágenes personalizadas
- Inicia docker-compose.lab.yml
- Inicia docker-compose.monitor.yml
- Muestra URLs de servicios disponibles
- Lista contenedores activos

#### stop_lab.ps1

- Detiene todos los contenedores
- Mantiene volúmenes y datos intactos
- Limpieza ordenada

#### reset_lab.ps1

- **DESTRUCTIVO**: Elimina todos los contenedores y volúmenes
- Requiere confirmación del usuario
- Limpia recursos de Docker
- Útil para empezar desde cero

#### access_kali.ps1

- Proporciona shell interactivo en Kali
- Verifica que el contenedor esté corriendo
- Usuario: attacker

#### status_lab.ps1

- Muestra estado de imágenes personalizadas
- Lista contenedores activos con puertos
- Muestra redes Docker
- Muestra volúmenes
- Estadísticas de uso de recursos

#### view_logs.ps1

Visualización flexible de logs de Suricata:

- `-LogType alerts`: Solo alertas de seguridad
- `-LogType eve`: Todos los eventos en formato JSON
- `-LogType fast`: Log rápido de alertas
- `-LogType http`: Tráfico HTTP
- `-LogType dns`: Consultas DNS
- `-LogType stats`: Estadísticas de Suricata
- `-LogType live`: Monitoreo en tiempo real

## 🔄 Flujo de Trabajo Típico

```
1. build_images.ps1      → Construir imágenes (solo primera vez)
                           ↓
2. start_lab.ps1         → Iniciar laboratorio
                           ↓
3. view_logs.ps1         → Monitorear en otra terminal
                           ↓
4. access_kali.ps1       → Realizar ataques
                           ↓
5. status_lab.ps1        → Verificar estado
                           ↓
6. stop_lab.ps1          → Detener al terminar
```

## 📊 Puertos Expuestos

| Puerto | Servicio   | Descripción                |
| ------ | ---------- | -------------------------- |
| 3001   | Juice Shop | Aplicación web vulnerable  |
| 8080   | DVWA       | Damn Vulnerable Web App    |
| 2222   | SSH        | Servidor SSH vulnerable    |
| 3000   | Grafana    | Dashboard de visualización |
| 9090   | Prometheus | Servidor de métricas       |
| 8081   | cAdvisor   | Métricas de contenedores   |

## 🌐 Redes Docker

### attacker_net (172.26.0.0/24)

- kali-attacker: 172.26.0.10

### lab_internal (172.25.0.0/24)

- juice-shop: 172.25.0.10
- mysql-db: 172.25.0.20
- dvwa: 172.25.0.21
- vuln-ssh: 172.25.0.30
- kali-attacker: 172.25.0.100
- suricata-ids: 172.25.0.200

### monitor_net (172.27.0.0/24)

- suricata-ids: 172.27.0.10
- cadvisor: 172.27.0.20
- prometheus: 172.27.0.30
- grafana: 172.27.0.40

## 💾 Volúmenes Docker

- `attacker_home`: Datos persistentes de Kali (/home/attacker)
- `mysql_data`: Base de datos MySQL
- `suricata_logs`: Logs de Suricata IDS
- `grafana_data`: Configuración de Grafana
- `prometheus_data`: Datos de métricas de Prometheus

## 🔒 Consideraciones de Seguridad

### Configuraciones de Seguridad Implementadas

1. **Redes Aisladas**: Segmentación de tráfico por función
2. **Usuario No-Root**: Kali ejecuta como usuario `attacker`
3. **Security Options**: `no-new-privileges:true` en contenedores críticos
4. **Resource Limits**: CPU y memoria limitadas por contenedor
5. **Logging**: Todos los contenedores tienen logging configurado

### Vulnerabilidades Intencionales

⚠️ **SOLO PARA LAB**: Este proyecto incluye:

- Aplicaciones vulnerables (Juice Shop, DVWA)
- Credenciales débiles (admin/password)
- SSH con autenticación por contraseña
- Base de datos con credenciales conocidas

**NUNCA exponer estos servicios a Internet o redes de producción**

## 🛠️ Personalización

### Agregar Nuevas Reglas de Suricata

1. Editar `configs/suricata-rules.rules`
2. Seguir formato: `alert <proto> <src> <dst> (msg:"..."; <opciones>; sid:<id>; rev:1;)`
3. Reiniciar Suricata: `docker restart suricata-ids`

### Agregar Herramientas a Kali

1. Editar `dockerfiles/Dockerfile.kali`
2. Agregar herramientas en la sección `RUN apt install`
3. Reconstruir: `.\scripts\build_images.ps1`

### Agregar Nuevos Servicios

1. Editar `compose/docker-compose.lab.yml`
2. Agregar servicio con configuración de red apropiada
3. Reiniciar: `.\scripts\start_lab.ps1`

### Personalizar Dashboards de Grafana

1. Acceder a Grafana (http://localhost:3000)
2. Crear/importar dashboards
3. Los datos persisten en el volumen `grafana_data`

## 📚 Recursos Adicionales

- Ver escenarios de práctica completos en `README.md`
- Comandos rápidos en `QUICK_START.md`
- Documentación oficial de cada herramienta en sus respectivos sitios web

---

**Última actualización**: Noviembre 2025
