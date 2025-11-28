# 🚀 Guía Rápida - Docker Security Lab

## Inicio Rápido (5 minutos)

```powershell
# 1. Construir imágenes (primera vez solamente)
.\scripts\build_images.ps1

# 2. Iniciar laboratorio
.\scripts\start_lab.ps1

# 3. Acceder a Kali
.\scripts\access_kali.ps1

# 4. Empezar a hackear!
```

## 📋 Comandos Esenciales

### Gestión del Laboratorio

```powershell
# Iniciar todo
.\scripts\start_lab.ps1

# Detener todo
.\scripts\stop_lab.ps1

# Ver estado
.\scripts\status_lab.ps1

# Reiniciar completamente (CUIDADO: Borra datos)
.\scripts\reset_lab.ps1

# Reconstruir imágenes
.\scripts\build_images.ps1
```

### Acceso a Contenedores

```powershell
# Kali Linux
.\scripts\access_kali.ps1

# Suricata IDS
docker exec -it suricata-ids bash

# MySQL
docker exec -it mysql-db mysql -uroot -prootpass

# Ver logs
docker logs <nombre-contenedor>
```

### Monitoreo

```powershell
# Alertas de seguridad en tiempo real
.\scripts\view_logs.ps1 -LogType alerts

# Todos los eventos
.\scripts\view_logs.ps1 -LogType eve

# HTTP traffic
.\scripts\view_logs.ps1 -LogType http

# Monitoreo live
.\scripts\view_logs.ps1 -LogType live
```

## 🎯 Targets de Práctica

### Juice Shop (http://localhost:3001)

- SQL Injection
- XSS
- Broken Authentication
- Sensitive Data Exposure
- XXE
- Broken Access Control

### DVWA (http://localhost:8080)

- **Usuario**: admin
- **Contraseña**: password
- Configurar nivel: Low → Medium → High
- Módulos: SQL Injection, Command Injection, File Upload, XSS

### SSH Vulnerable (localhost:2222)

- **Usuario**: admin
- **Contraseña**: password123
- Práctica de brute force

## 🔍 Ataques Rápidos desde Kali

### Escaneo de Red

```bash
nmap -sn 172.25.0.0/24                    # Descubrir hosts
nmap -sV -sC 172.25.0.10                  # Escaneo completo Juice Shop
nmap -p- --min-rate 1000 172.25.0.21      # Escaneo rápido DVWA
```

### SQL Injection

```bash
# Manual
curl "http://172.25.0.10/rest/user/login" \
  -H "Content-Type: application/json" \
  -d '{"email":"admin'\''--","password":"x"}'

# SQLMap
sqlmap -u "http://172.25.0.21/vulnerabilities/sqli/?id=1" \
  --cookie="PHPSESSID=xxx;security=low" --dbs
```

### Enumeración Web

```bash
gobuster dir -u http://172.25.0.21/ \
  -w /usr/share/wordlists/dirb/common.txt

nikto -h http://172.25.0.21/
```

### Brute Force

```bash
hydra -l admin -P /usr/share/wordlists/rockyou.txt \
  ssh://172.25.0.30:2222
```

## 📊 URLs Importantes

| Servicio   | URL                   | Credenciales   |
| ---------- | --------------------- | -------------- |
| Juice Shop | http://localhost:3001 | -              |
| DVWA       | http://localhost:8080 | admin/password |
| Grafana    | http://localhost:3000 | admin/admin    |
| Prometheus | http://localhost:9090 | -              |
| cAdvisor   | http://localhost:8081 | -              |

## 🔧 Solución Rápida de Problemas

### Contenedor no inicia

```powershell
docker logs <nombre>
docker restart <nombre>
```

### Puerto ocupado

```powershell
netstat -ano | findstr :8080
taskkill /PID <pid> /F
```

### Sin espacio en disco

```powershell
docker system prune -a --volumes
```

### Suricata no detecta

```powershell
docker restart suricata-ids
docker logs suricata-ids
```

### Reset completo

```powershell
.\scripts\reset_lab.ps1
.\scripts\build_images.ps1
.\scripts\start_lab.ps1
```

## 📈 Workflow Típico de Práctica

1. **Iniciar laboratorio**

   ```powershell
   .\scripts\start_lab.ps1
   ```

2. **Abrir monitoreo en otra terminal**

   ```powershell
   .\scripts\view_logs.ps1 -LogType live
   ```

3. **Acceder a Kali**

   ```powershell
   .\scripts\access_kali.ps1
   ```

4. **Realizar ataque**

   ```bash
   # Ejemplo: escaneo
   nmap -sV 172.25.0.0/24
   ```

5. **Verificar detección en logs**

   - Ver alertas de Suricata
   - Analizar en Grafana

6. **Limpiar al terminar**
   ```powershell
   .\scripts\stop_lab.ps1
   ```

## 🎓 Recursos de Aprendizaje

- **OWASP Top 10**: https://owasp.org/www-project-top-ten/
- **PortSwigger Academy**: https://portswigger.net/web-security
- **HackTheBox**: https://www.hackthebox.com/
- **TryHackMe**: https://tryhackme.com/

## 💡 Tips Pro

1. **Siempre monitorea mientras atacas**: Ver cómo Suricata detecta tus ataques es educativo

2. **Usa jq para analizar logs JSON**:

   ```bash
   docker exec -it suricata-ids bash
   cat /var/log/suricata/eve.json | jq 'select(.event_type=="alert")'
   ```

3. **Configura dashboards en Grafana** para visualización en tiempo real

4. **Practica en orden de dificultad**:

   - Low → Medium → High → Impossible (DVWA)

5. **Documenta tus hallazgos**: Mantén notas de técnicas que funcionan

## ⚠️ Importante

- **NUNCA expongas este laboratorio a Internet**
- **Usa SOLO en entorno local**
- **No uses estas técnicas sin autorización**
- **Detén el lab cuando no lo uses**

## 🆘 Ayuda Rápida

```powershell
# Ver todos los contenedores
docker ps -a

# Ver todas las redes
docker network ls

# Ver todos los volúmenes
docker volume ls

# Logs de un contenedor
docker logs -f <nombre>

# Estadísticas en tiempo real
docker stats

# Estado completo
.\scripts\status_lab.ps1
```

---

**Happy Hacking! 🔒**

Para más detalles, consulta el [README.md](README.md) completo.
