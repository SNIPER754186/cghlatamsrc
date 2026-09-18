# 3_CODIGOVOLCADOFINAL (Repo 3 Final)

Volcado final **desofuscado** del instalador **ADMcgh / CHUMOPLUS** (ecosistema @ChumoGH),
listo para su distribución. Todo el análisis se hizo de forma **100% estática**
(0% ejecución en shell).

## Archivos

| Archivo | Origen | Técnica de ofuscación resuelta | Tamaño |
| :--- | :--- | :--- | ---: |
| `setup_limpio.sh` | `https://plus.ltmcgh.site/setup` | Bashfuscator (matriz octal/hex) | 24 KB |
| `pack_new_limpio.sh` | `https://plus.ltmcgh.site/pack_new` | Sustitución de variables concatenadas | 16.5 KB |
| `pack_new_desde2b.sh` | `pack_new` (variante tipo 2b) | Base64 por variables + `eval` + cebo | 0.9 KB |
| `pack3_limpio.sh` | GitHub `.../Plugins/system/pack3.tar` | Multi-capa (Base64 + BZIP2 + GZIP) | 17 KB |
| `menu_limpio.sh` | `SCRIPT.tar.gz` → `menu` | `${@...}` anidado (gzip + bzip2) | 342 KB |
| `LATAM_limpio.sh` | Github `.../Instalador/LATAM` | Base64 por variables + `eval` + 25 chars de cebo | 18 KB |
| `ScriptCGH_setup_limpio.sh` | GitHub `.../ScriptCGH/main/setup` | Vars+`eval` con posicionales `$1..$9` borrados (esqueleto) | 20.6 KB |
| `styles_limpio.sh` | GitHub `.../Plugins/system/styles.cpp` | Texto plano (renombrado a `.cpp`) | 9 KB |

## Rutas reescritas a GitHub raw

Las rutas que apuntaban al espejo local fueron reemplazadas por este repositorio:

| Antes | Ahora |
| :--- | :--- |
| `http://64.176.5.61/CHUMOPLUS/mirror/` | `https://raw.githubusercontent.com/SNIPER754186/cghlatamsrc/main/mirror/` |
| `http://localhost/pkdlatamsrc/CHUMOPLUS/mirror/` | `https://raw.githubusercontent.com/SNIPER754186/cghlatamsrc/main/mirror/` |

Archivo afectado: **`setup_limpio.sh`** (12 rutas reescritas).
El resto de archivos conserva sus URLs originales porque su espejo no está incluido
en `mirror/` (requieren el keygen vivo en `IP:81` / `IP:8888`, o dependen del
generador dinámico por KEY/IP).

## Aviso

Estos scripts son altamente invasivos (reemplazo de `sources.list`, borrado de
`auth.log`, persistencia en `cron` como root, vaciado de `iptables`, descarga y
ejecución remota en memoria con `bash -c`). Se publican **solo con fines de
auditoría, estudio forense y análisis estático**. No los ejecutes en una máquina
de producción.
