# cghlatamsrc

Repositorio de instalación **ADM línea LATAM** (ChumoGH), con keygen propio por SQL.

> **Owner / Maintainer:** `@gatesccn`
> **Creador original del script:** Henry Chumo (`@ChumoGH`)

---

## ⚡ Instalación Rápida (Cliente Final)

Solo se entrega **1 URL + 1 KEY**. No se entregan fuentes.

### Opción 1 - Instalador ADM CGH (recomendado)

```bash
bash <(curl -sSL http://64.176.5.61:81/setup.sh) --key LatamSRC--TU_KEY_AQUI
```

### Opción 2 - Instalador LATAM

```bash
bash <(curl -sSL http://64.176.5.61:81/latam.sh) --key LatamSRC--TU_KEY_AQUI
```

### Modo interactivo (pide la key en pantalla)

```bash
bash <(curl -sSL http://64.176.5.61:81/setup.sh)
```

---

## 🔑 Generación de Keys

Las keys se generan **únicamente** en el VPS CyberPanel (Keygen Central):

- **Generar:** `https://chumoadmin.arcando.cloud/api-db.php?action=generate`
- **Listar:** `https://chumoadmin.arcando.cloud/api-db.php?action=list`
- **Verificar:** `https://chumoadmin.arcando.cloud/api-db.php?action=check&key=LATAMSRC--...`
- **Consumir:** `https://chumoadmin.arcando.cloud/api-db.php?action=consume&key=LATAMSRC--...`

**Política de cada key:**
- Formato: `LatamSRC--XXXXXXXXXXXXXXXX`
- Validez: **4 horas**
- Usos: **1 solo uso** (se quema al instalar y se registra la IP que la consumió)

---

## 🖥️ Servidores

| Rol | IP | Dominio |
| :--- | :--- | :--- |
| VPS Instalador (este repo) | `64.176.5.61` | `keygen.arcando.cloud` (puerto 81) |
| VPS Keygen Central (CyberPanel SQL) | `185.194.204.159` | `chumoadmin.arcando.cloud` |

> ⚠️ **El puerto 8888 está cerrado en el VPS instalador.** Aquí NO se genera ni se expone ningún keygen. Todo el control de licencias vive en el VPS CyberPanel.

---

## 📦 Estructura del Repositorio

```
.
├── README.md                       # Este archivo (manual de uso)
├── registrocambios.md              # Bitácora de avances / dónde continuar
├── bylatamsrc.html                 # Landing page propia (reemplaza la de Chumo)
│
├── _repo3/                         # Volcados limpios y desofuscados (Capa 3)
│   ├── setup_limpio.sh             706 líneas  · instalador principal
│   ├── menu_limpio.sh              9.466 líneas · EL MENÚ REAL
│   ├── pack_new_limpio.sh          441 líneas  · capa 2
│   ├── pack3_limpio.sh             454 líneas  · fallback
│   ├── styles_limpio.sh            283 líneas  · msg-bar / estilos
│   └── LATAM_limpio.sh             463 líneas  · variante LATAM
│
└── CHUMOPLUS/                      # Espejo local de archivos de runtime
    └── mirror/                      (binarios, plugins, tokens)
```

---

## 🛠️ Herramientas de Auditoría (privado)

En este repo **no** viven scripts Python de keygen ni paneles generadores.
Los desofuscadores y utilidades de análisis están fuera del alcance público.

---

## 📌 Identidad visual

El menú instalado muestra:

```
   ______ __                 ______ __  __
  / ____// /_ __ __ ___ ___ / ____// / / /
 / /    / __// // // __ `__ \/ / __ / /_/ / 
/ /___ / /_ / // // / / / / / /_/ // __  /  
\____/ \__/ \_,_//_/ /_/ /_/\____//_/ /_/   
                                            
                      By LatamSRC
```

Nombre original (`ChumoGH`) conservado por confianza, con atribución de owner debajo.

---

## 📲 Contacto / Soporte

- **Telegram:** `@gatesccn`
- **Reseller activo:** configurable por el campo `creator` de cada key en el keygen SQL

---

## ⚠️ Aviso legal

Material de instalación de servidores SSH/VPN (ADM). El creador original del script es Henry Chumo (`@ChumoGH`); este fork mantiene atribución y añade gestión de licencias propia.
