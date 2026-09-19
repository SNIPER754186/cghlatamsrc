# Registro de Cambios - Proyecto cghlatamsrc
**Owner:** @gatesccn | **Creador original del script:** Henry Chumo (@ChumoGH)
**Fecha:** 19/09/2026
**VPS Instalador:** 64.176.5.61 (paanelfree)
**VPS Keygen Central (CyberPanel SQL):** 185.194.204.159 / chumoadmin.arcando.cloud

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
| ADM CGH (principal) | `http://64.176.5.61:81/setup.sh` | Adaptado API SQL + TERM OK |
| LATAM (variante) | `http://64.176.5.61:81/latam.sh` | Adaptado API SQL + TERM OK |

**Comando de instalación para cliente:**
```bash
bash <(curl -sSL http://64.176.5.61:81/setup.sh) --key LatamSRC--XXXX
```

---

## ENDPOINTS DEL KEYGEN (VPS CYBERPANEL)

- Generar: `https://chumoadmin.arcando.cloud/api-db.php?action=generate`
- Listar:  `https://chumoadmin.arcando.cloud/api-db.php?action=list`
- Check:   `https://chumoadmin.arcando.cloud/api-db.php?action=check&key=LATAMSRC--...`
- Consumir:`https://chumoadmin.arcando.cloud/api-db.php?action=consume&key=LATAMSRC--...`

Política: key de 4h, 1 solo uso, IP consumida registrada en `used_by_ip`.
