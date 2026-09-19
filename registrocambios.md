# Registro de Cambios - Proyecto cghlatamsrc
**Owner:** @gatesccn | **Creador original del script:** Henry Chumo (@ChumoGH)
**Fecha:** 19/09/2026
**Repo/Instaladores:** dominio `chumoadmin.arcando.cloud`
**VPS Keygen Central:** CyberPanel (SQL) en `chumoadmin.arcando.cloud`

---

## DÓNDE CONTINUAR LA PRÓXIMA VEZ

1. **Pendiente:** Limpieza final del repo en GitHub (borrar `2_CODIGOANALIZADO/`, `3_CODIGOVOLCADOFINAL/`, `1_CODIGOORIGINAL/` si se decide hacerlo privado).
2. **Pendiente:** Probar instalación completa del `latam.sh` (aún no testeado end-to-end).
3. **Pendiente:** Verificar que el bot de Telegram del VPS CyberPanel use el campo `creator` para el banner reseller.

---

## COMPLETADO EN ESTA SESIÓN

- [x] **Puerto 8888 cerrado** en el VPS instalador. Deshabilitados `latamsrc-keygen.service` y `latamsrc-bot.service`. Eliminado `/var/www/keygen/`. El keygen NUNCA debe correr aquí (repo = instalador, no generador).
- [x] **Nginx reconfigurado:** puertos 80 y 81 sirviendo `/var/www/html` (index = bylatamsrc.html) + política de puerto 81 sirviendo módulos.
- [x] **Landing page:** `/var/www/html/index.html` = `bylatamsrc.html`. También reemplazado en el mirror `plugin.html`.
- [x] **Banner del menú:** `ChumoGH` grande (figlet standard) + `By LatamSRC` pequeño debajo. Línea 780 de `_repo3/menu_limpio.sh`.
- [x] **Fix `TERM environment variable not set`:** agregado `export TERM="${TERM:-xterm-256color}"` en setup.sh, latam.sh y pack_new_limpio.sh.
- [x] **Fix aviso `⚠️ No se encontró /etc/adm-lite/file.tar`:** silenciado (es opcional, no aplica al flujo actual).
- [x] **README.md reescrito:** manual de uso de ambos instaladores (setup.sh y latam.sh), endpoints del keygen SQL, tabla de servidores, identidad visual.
- [x] **Git resuelto:** fetch + reset --hard origin/main para integrar el commit `ac6db7c` de la PC, luego restaurados los cambios locales.
- [x] **Confirmado:** ambos instaladores ya usan `api-db.php` (consume/check con la key `LatamSRC--`). No hay keys fijas en producción.

---

## ESTADO DE LOS 2 INSTALADORES

| Instalador | Ruta pública | Estado |
| :--- | :--- | :--- |
| ADM CGH (principal) | `chumoadmin.arcando.cloud/bash/setup.sh` | Adaptado API SQL |
| LATAM (variante) | `chumoadmin.arcando.cloud/bash/latam.sh` | Adaptado API SQL |

**Comando de instalación para cliente:**
```bash
wget -q https://chumoadmin.arcando.cloud/bash/setup.sh -O setup.sh && ./setup.sh --key LatamSRC--XXXX
```

---

## ENDPOINTS DEL KEYGEN (VPS CYBERPANEL)

- Generar: `https://chumoadmin.arcando.cloud/api-db.php?action=generate`
- Listar:  `https://chumoadmin.arcando.cloud/api-db.php?action=list`
- Check:   `https://chumoadmin.arcando.cloud/api-db.php?action=check&key=LATAMSRC--...`
- Consumir:`https://chumoadmin.arcando.cloud/api-db.php?action=consume&key=LATAMSRC--...`

Política: key de 4h, 1 solo uso, IP consumida registrada en `used_by_ip`.

---

## SESIÓN 19/09/2026 (tarde) — Reestructuración Anti-IP-Fija

### Problema detectado
Los instaladores apuntaban a IPs fijas de la VPS.
Si cambiaba de VPS, **todas las instalaciones del mundo se rompían.**

### Solución aplicada
- [x] **TODAS las IPs fijas eliminadas** de los 4 scripts de producción.
- [x] **Todo apunta al dominio** `https://chumoadmin.arcando.cloud/...` (Cloudflare proxy).
- [x] **Creada carpeta limpia `bash/`** con SOLO los 6 scripts de producción:
  - `setup.sh`, `latam.sh` (públicos)
  - `pack_new.sh`, `pack3.sh`, `menu.sh`, `styles.cpp` (internos)
- [x] **Creada carpeta `audit/`** para herramientas Python de análisis.
- [x] **`setup.sh` y `latam.sh`:** eliminado el bloque "GENERADOR NO AUTORIZADO" (la validación real la hace `api-db.php`). Ya no hay IP de generador hardcodeada.
- [x] **`IiP` ahora es la IP LOCAL del cliente:** usa `hostname -I | awk '{print $1}'` con fallback a `ifconfig.me`. Nunca hardcodeada.
- [x] **Parser universal de argumentos** en ambos instaladores: acepta `--key`, `-k`, `--Latam`, `--latam`, `--ADMcgh`, y key suelta (`LatamSRC--...`).
- [x] **`pack_new.sh`/`pack3.sh`:** rutas de terceros (`ChumoGH/ADMcgh`, `plus.ltmcgh.site`, Dropbox) → mirror propio del repo o keygen propio.
- [x] **README.md reescrito:** comandos con `wget` al dominio, sin IPs.
- [x] **FLUJO.md creado:** diagrama de qué script llama a cuál.

### Nuevos comandos de instalación (cliente)
```bash
# ADM CGH
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/setup.sh -O setup.sh
chmod 777 setup.sh && ./setup.sh --key LatamSRC--XXXX

# LATAM
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/latam.sh -O latam.sh
chmod 777 latam.sh && ./latam.sh --key LatamSRC--XXXX
```

### Puertos que necesita el CLIENTE
**NINGUNO de entrada.** Solo salida HTTPS (443) hacia el dominio del keygen.

### PENDIENTE para la próxima sesión
1. Subir la carpeta `bash/` al VPS CyberPanel en `/bash/`.
2. Borrar las carpetas viejas del repo GitHub: `_repo3/`, `2_CODIGOANALIZADO/`, `3_CODIGOVOLCADOFINAL/`, `1_CODIGOORIGINAL/` (ya migradas a `bash/` y `audit/`).
3. Probar la instalación real de `latam.sh` end-to-end.

---

## VERIFICACIÓN FINAL (19/09/2026)

- ✅ `bash/setup.sh` y `bash/latam.sh` descargados desde GitHub → **sintaxis OK**.
- ✅ Parser universal probado: acepta `--key`, `-k`, `--Latam`, `--latam`, `--ADMcgh`.
- ✅ Endpoints apuntan al dominio: `chumoadmin.arcando.cloud/api-db.php`, `/bash/pack_new.sh`, `/bash/modules/`.
- ✅ **0 IPs fijas** en `setup.sh` y `latam.sh` (verificado con grep en GitHub raw).
- ✅ Estructura en GitHub: `bash/` (6 scripts prod) + `audit/` + docs.

### Estructura final en GitHub
```
cghlatamsrc/
├── README.md              ← manual del cliente
├── FLUJO.md               ← diagrama técnico
├── registrocambios.md     ← bitácora
├── bylatamsrc.html        ← landing
├── .gitignore
├── bash/                  ← PRODUCCIÓN (subir a CyberPanel)
│   ├── setup.sh, latam.sh (públicos)
│   └── pack_new.sh, pack3.sh, menu.sh, styles.cpp (internos)
├── audit/                 ← ANÁLISIS
├── CHUMOPLUS/             ← espejo raw (binarios/plugins)
└── _repo3/                ← volcados originales (pendiente borrar)
```

---

## SESIÓN 19/09/2026 (noche) — Consolidación Total + Pruebas Reales

### PROBLEMA RAÍZ: 3 copias del mismo código
| Ubicación | Estado | Destino |
|---|---|---|
| `/root/CHUMOPLUS/` | Original de Chumo (referencia) | mirror se sincroniza aquí |
| `/root/cghlatamsrc/CHUMOPLUS/` | Edición vieja con IPs | Consolidada |
| `/root/cghlatamsrc/_repo3/` | La más nueva | → movida a `bash/` |

### CONSOLIDACIÓN HECHA
- [x] **Eliminados duplicados:** `_repo3/`, `2_CODIGOANALIZADO/`, `4_INSTALACION/`
- [x] **Estructura final:** `bash/` (prod) + `CHUMOPLUS/` (datos) + `audit/` (análisis)
- [x] **Control unificado:** `185.194.204.159 | @chumodgatesccn_Bot | @gatesccn` en ambos control
- [x] **Ruta mirror correcta:** `CHUMOPLUS/mirror/...` (14/14 rutas → 200 OK)

### BUGS REALES ENCONTRADOS Y CORREGIDOS
1. **`dropbox/msg` era HTML roto** (capturado mal en auditoría) → reemplazado con `styles.cpp` real
2. **`plus.ltmcgh.site/ChumoGH/msg`** → mismo fix
3. **`latam.sh` wrapper buscaba `./menu.sh`** (no existe) → corregido a `./menu`
4. **Falta de archivos de estado** (`v-local.log`, `v-new.log`, `exito`) → ahora se crean en rutas LATAM + ADM
5. **`setup.sh` llamaba a pack_new local inexistente** → ahora dominio + fallback GitHub
6. **README exponía endpoints del API** → ocultados, ahora dice "contactar @gatesccn"

### PRUEBAS REALES EJECUTADAS
- ✅ **LATAM:** instalado, menú carga, key consumida, creditos = creator de la key
- ✅ **SETUP (ADM CGH):** instalado, menú carga con banner ChumoGH + By LatamSRC
- ✅ **Desinstalación LATAM:** limpia (`rm -rf /etc/SCRIPT-LATAM`)

### ⚠️ IMPORTANTE: CACHÉ de raw.githubusercontent
GitHub actualiza los archivos pero `raw.githubusercontent.com` tiene **5-10 min de caché**.
Si un `.sh` parece viejo, esperar o añadir `?nocache=<timestamp>`.

### COMANDOS FINALES PARA CLIENTE
```bash
# ADM CGH
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/setup.sh -O setup.sh
chmod 777 setup.sh && ./setup.sh --key LatamSRC--XXXX

# LATAM (variante NetVPS)
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/latam.sh -O /usr/bin/LATAM
chmod +x /usr/bin/LATAM
LATAM --key LatamSRC--XXXX
```

### PENDIENTE
1. Subir `bash/modules/` (módulos del menú) al CyberPanel en `/bash/modules/`.
2. Probar `setup.sh` completo sin cortar por timeout (tarda ~4 min por npm/nodejs).
