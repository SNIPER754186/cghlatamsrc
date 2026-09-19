# cghlatamsrc

Repositorio de instalación **ADM línea LATAM** (ChumoGH), con keygen propio por SQL.

> **Owner / Maintainer:** `@gatesccn`
> **Creador original del script:** Henry Chumo (`@ChumoGH`)

---

## ⚡ Instalación Rápida (Cliente Final)

**No necesitas abrir ningún puerto.** Solo tienes que generar tu key y ejecutar 1 comando.

### Paso 1 — Genera tu key (4 horas, 1 solo uso)

Contacta a **@gatesccn** en Telegram (`https://t.me/gatesccn`) y solicita tu key.

Te entregarán una key con formato `LatamSRC--XXXXXXXXXXXXXXXX` válida por **4 horas**.

> **Se quema al instalar.** Cada key sirve para 1 sola VPS.

### Paso 2 — Instala en tu VPS

**Opción A — Instalador ADM CGH (el normal):**
```bash
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/setup.sh -O setup.sh
chmod 777 setup.sh
./setup.sh --key LatamSRC--TU_KEY
```

**Opción B — Instalador LATAM (variante NetVPS):**
```bash
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/latam.sh -O /usr/bin/LATAM
chmod +x /usr/bin/LATAM
LATAM --key LatamSRC--TU_KEY
```
> También funciona interactivo: `LATAM` (sin `--key`) y pegas la key cuando la pida.

**Opción C — Sin parámetros (pide la key en pantalla):**
```bash
wget -q https://chumoadmin.arcando.cloud/bash/setup.sh -O setup.sh
chmod 777 setup.sh
./setup.sh
```

### Paso 3 — Abre el panel

```bash
menu
```

---

## 🔑 Keygen Central

Las keys se generan desde el **panel privado del Owner** en el VPS CyberPanel.
Los endpoints del API **no son públicos** por seguridad.

Contacta a `@gatesccn` en Telegram para obtener tu key.

## 📡 ¿Qué endpoints usa el instalador?

Todo pasa por **HTTPS (443) saliente** hacia el dominio. **El cliente no abre nada de entrada.**

| Paso | Destino | Puerto |
| :--- | :--- | :--- |
| Verificar key | `chumoadmin.arcando.cloud` | 443 saliente |
| Descargar `pack_new` | `chumoadmin.arcando.cloud/bash/pack_new.sh` | 443 saliente |
| Descargar módulos | `chumoadmin.arcando.cloud/bash/modules/...` | 443 saliente |
| Panel web local | la IP del propio cliente | 81 (lo abre su nginx) |

> **Por qué usar dominio y no IP:** si el keygen cambia de VPS, solo actualizas el DNS de Cloudflare. Nada en los instaladores se rompe.

---

## 📂 Estructura del Repositorio (ordenada)

```
cghlatamsrc/
├── README.md              # Este manual (para el cliente)
├── FLUJO.md               # Diagrama técnico del flujo entre scripts
├── registrocambios.md     # Bitácora de avances
├── bylatamsrc.html        # Landing page oficial
│
├── bash/                  # ★ LO QUE SE SUBE AL VPS KEYGEN
│   ├── setup.sh           #   → instalador ADM CGH   (público)
│   ├── latam.sh           #   → instalador LATAM      (público)
│   ├── pack_new.sh        #   → capa 2, la llama setup.sh (interno)
│   ├── pack3.sh           #   → capa 2 fallback        (interno)
│   ├── menu.sh            #   → el panel final         (interno)
│   └── styles.cpp         #   → motor msg              (interno)
│
└── audit/                 # ★ SOLO ANÁLISIS (no producción)
    ├── desofuscadores/    #   herramientas Python
    └── originales/        #   volcados sin tocar
```

**Regla:** `bash/` = producción; `audit/` = análisis.

---

## 🖥️ Servidores

| Rol | Dominio | Notas |
| :--- | :--- | :--- |
| Keygen Central (SQL) + `/bash/` | `chumoadmin.arcando.cloud` | VPS CyberPanel, Cloudflare proxy |
| Repo espejo (raw) | `raw.githubusercontent.com/SNIPER754186/cghlatamsrc/main/CHUMOPLUS/mirror/` | binarios y plugins |

> ⚠️ Los instaladores **no tienen IPs fijas**. Todo apunta al dominio.

---

## 📌 Identidad visual

El panel instalado muestra:

```
   ______ __                 ______ __  __
  / ____// /_ __ __ ___ ___ / ____// / / /
 / /    / __// // // __ `__ \/ / __ / /_/ /
/ /___ / /_ / // // / / / / / /_/ // __  /
\____/ \__/ \_,_//_/ /_/ /_/\____//_/ /_/

                      By LatamSRC
```

Se conserva el nombre original (`ChumoGH`) por confianza de la comunidad, con la atribución del nuevo owner debajo.

---

## 📲 Contacto

- **Telegram:** `@gatesccn`
- **Reseller:** configurable por el campo `creator` de cada key en el keygen SQL

---

## ⚠️ Aviso legal

Material de instalación de servidores SSH/VPN (ADM). Creador original: Henry Chumo (`@ChumoGH`). Este fork mantiene atribución y añade gestión de licencias propia.
