# homebrew-sandra

Formulas y Casks de Homebrew para el Ecosistema Sandra.

## 📦 Paquetes Disponibles

### Formulas (Herramientas de línea de comandos)

#### `sandra-server`
Servidor middleware empresarial de Sandra.

#### `sandra-sentinel`
Motor de cálculo de nómina militar desarrollado en Rust. Se conecta a Sandra Server via gRPC para procesar datos de nómina de alta complejidad.

```bash
# Instalar
brew tap code-epic/sandra
brew install sandra-sentinel

# Ejecutar ciclo de nómina
sandra-sentinel start -x -m manifest.json

# Ver ayuda
sandra-sentinel --help
```

**Características:**
- ✅ Procesamiento de ~500k+ registros en segundos
- ✅ Conexión gRPC a Sandra Server (puerto 50051)
- ✅ Soporte para múltiples tipos de nómina (NPR, NACT, NRCP, NFCP)
- ✅ Exportación a CSV y formatos bancarios (Venezuela, Banfanb, Bicentenario)
- ✅ Cálculo determinístico de nómina militar
- ✅ Compresión y hashing de archivos de salida

```bash
# Instalar
brew tap code-epic/sandra
brew install sandra-server

# Iniciar servicio
sudo brew services start sandra-server

# Ver estado
sudo brew services list | grep sandra-server
```

**Características:**
- ✅ Soporte para Intel (AMD64) y Apple Silicon (ARM64)
- ✅ Integración con launchd/macOS
- ✅ Gestión via `brew services`
- ✅ Logs automáticos
- ✅ Configuración en `/opt/homebrew/etc/sandra/` (Apple Silicon) o `/usr/local/etc/sandra/` (Intel)

#### `sandra-sentinel`
Motor de cálculo de nómina militar desarrollado en Rust. Se conecta a Sandra Server via gRPC para procesar datos de nómina de alta complejidad.

```bash
# Instalar
brew tap code-epic/sandra
brew install sandra-sentinel

# Ejecutar ciclo de nómina
sandra-sentinel start -x -m manifest.json

# Ver ayuda
sandra-sentinel --help
```

**Características:**
- ✅ Procesamiento de ~500k+ registros en segundos
- ✅ Conexión gRPC a Sandra Server (puerto 50051)
- ✅ Soporte para múltiples tipos de nómina (NPR, NACT, NRCP, NFCP)
- ✅ Exportación a CSV y formatos bancarios (Venezuela, Banfanb, Bicentenario)
- ✅ Cálculo determinístico de nómina militar
- ✅ Compresión y hashing de archivos de salida

### Casks (Aplicaciones de escritorio)

#### `sandra-desktop-container`
Sandra Desktop Container (SDC) - Plataforma de orquestación segura.

```bash
# Instalar
brew tap code-epic/sandra
brew install --cask sandra-desktop-container

# O directamente
brew install --cask code-epic/sandra/sandra-desktop-container
```

## 🚀 Uso Rápido

### Primera vez

```bash
# 1. Agregar el tap
brew tap code-epic/sandra

# 2. Instalar servidor
brew install sandra-server

# 3. Configurar (opcional)
# Editar: /opt/homebrew/etc/sandra/sandra.ini

# 4. Iniciar servicio
sudo brew services start sandra-server

# 5. Verificar
open https://localhost/consola
```

### Gestión del Servicio

```bash
# Iniciar
sudo brew services start sandra-server

# Detener
sudo brew services stop sandra-server

# Reiniciar
sudo brew services restart sandra-server

# Ver logs
brew services log sandra-server
tail -f /opt/homebrew/var/sandra/log/sandrad.out.log
```

## 📋 Requisitos

- macOS 11.0 (Big Sur) o superior
- Homebrew 3.0 o superior
- Para puertos bajos (80, 443): privilegios de administrador

## 🔧 Configuración

### Ubicaciones

| Componente | Apple Silicon | Intel |
|------------|---------------|-------|
| Binarios | `/opt/homebrew/bin/` | `/usr/local/bin/` |
| Configuración | `/opt/homebrew/etc/sandra/` | `/usr/local/etc/sandra/` |
| Datos | `/opt/homebrew/var/sandra/` | `/usr/local/var/sandra/` |
| Logs | `/opt/homebrew/var/sandra/log/` | `/usr/local/var/sandra/log/` |

### Configuración PHP (Opcional)

```bash
# Instalar PHP
brew install php@8.3
brew link php@8.3 --force

# Actualizar sandra.ini
# php_cgi = /opt/homebrew/bin/php
```

### Integración Server + Sentinel

Para utilizar el ecosistema completo de Sandra:

```bash
# 1. Instalar ambos componentes
brew install sandra-server sandra-sentinel

# 2. Iniciar Sandra Server (proporciona API gRPC)
sudo brew services start sandra-server

# 3. Verificar que Server esté funcionando
curl -k https://localhost/api/health

# 4. Ejecutar Sentinel conectado a Server
sandra-sentinel start -x -m ~/Documents/manifest.json
```

**Arquitectura de Integración:**

```
┌─────────────────┐     gRPC      ┌──────────────────┐
│  Sandra Server  │◄──────────────►│ Sandra Sentinel  │
│   (Go)          │   Puerto 50051 │   (Rust)         │
│   Puerto 80/443 │                │   CLI Tool       │
└─────────────────┘                └──────────────────┘
        │                                   │
        ▼                                   ▼
┌─────────────────┐                ┌──────────────────┐
│   Consola Web   │                │   Archivos CSV   │
│   (Angular)     │                │   TXT Bancarios  │
└─────────────────┘                └──────────────────┘
```

**Puertos Utilizados:**

| Servicio | Puerto | Protocolo | Descripción |
|----------|--------|-----------|-------------|
| Sandra Server HTTP | 80 | HTTP | Servidor web principal |
| Sandra Server HTTPS | 443 | HTTPS | Servidor web seguro |
| Sandra Server gRPC | 50051 | gRPC | API de cálculo (Sentinel) |
| Sandra Server Chat | 8443 | WebSocket | Chat en tiempo real |

**Ejemplo de Manifiesto (manifest.json):**

```json
{
  "nombre": "Nómina Enero 2026",
  "ciclo": "2026-01",
  "descripcion": "Ejecución oficial",
  "version": "1.0.0",
  "salida": {
    "destino": "~/nomina/output",
    "compresion": true,
    "nivel_compresion": 3,
    "format_txt": "aporte",
    "bancos": ["0102", "0177"]
  },
  "aportes": {
    "habilitar": true,
    "monto_aprobado_garantias": 40000000.00
  },
  "cargas": {
    "IPSFA_CBase": {
      "sql_filter": "status_id = 201"
    }
  }
}
```

## 🔄 Actualización

```bash
# Actualizar fórmulas
brew update

# Verificar actualizaciones
brew outdated | grep sandra

# Actualizar
brew upgrade sandra-server

# Reiniciar servicio
sudo brew services restart sandra-server
```

## ❌ Desinstalación

```bash
# Detener servicio
sudo brew services stop sandra-server

# Desinstalar servidor
brew uninstall sandra-server

# Desinstalar cask (opcional)
brew uninstall --cask sandra-desktop-container

# Remover tap
brew untap code-epic/sandra

# Limpiar datos (opcional)
sudo rm -rf /opt/homebrew/var/sandra
sudo rm -rf /opt/homebrew/etc/sandra
```

## 🐛 Solución de Problemas

### El servicio no inicia

```bash
# Verificar logs
tail -f /opt/homebrew/var/sandra/log/sandrad.err.log

# Verificar permisos
ls -la /opt/homebrew/var/sandra/
sudo chown -R sandra:sandra /opt/homebrew/var/sandra

# Reiniciar
sudo brew services restart sandra-server
```

### Problemas con puertos bajos (80, 443)

```bash
# Verificar puertos en uso
sudo lsof -i :80
sudo lsof -i :443

# Matar procesos si es necesario
sudo kill -9 <PID>
```

### Firewall

```bash
# Verificar estado
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Añadir excepción
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /opt/homebrew/bin/sandrad
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --unblockapp /opt/homebrew/bin/sandrad
```

### Problemas de Conexión Sentinel → Server

```bash
# Verificar que Server esté escuchando en puerto 50051
sudo lsof -i :50051

# Verificar logs de Sentinel
tail -f /opt/homebrew/var/sandra-sentinel/log/sentinel.err.log

# Probar conexión gRPC manualmente
# (Requiere grpcurl: brew install grpcurl)
grpcurl -plaintext localhost:50051 list

# Verificar que el manifiesto sea válido
sandra-sentinel start --help
```

### Problemas de Compilación (Sentinel)

```bash
# Si la instalación falla por dependencias Rust
rustup update
brew reinstall protobuf

# Limpiar y reinstalar
brew uninstall sandra-sentinel
brew cleanup
brew install sandra-sentinel
```

## 📚 Documentación

- [Instalación en macOS](https://github.com/code-epic/sandra/tree/main/docs/install/MACOS.md)
- [Instalación en Linux](https://github.com/code-epic/sandra/tree/main/docs/install/LINUX.md)
- [Wiki del Proyecto](https://github.com/code-epic/sandra/wiki)

## 🔗 Repositorios Relacionados

- [Sandra Server](https://github.com/code-epic/sandra) - Servidor principal (Go)
- [Sandra Sentinel](https://github.com/code-epic/sandra.sentinel) - Motor de cálculo (Rust)
- [Sandra Desktop Container](https://github.com/code-epic/sandra-desktop-container) - Cliente de escritorio

## 📄 Licencia

MIT License - Ver [LICENSE](LICENSE) para detalles.

---

**Mantenedor**: Carlos Peña - Code Epic Technologies
