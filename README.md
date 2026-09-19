# cghlatamsrc

Repositorio de instalación **ADM línea LATAM** (ChumoGH), con keygen propio por SQL.

> **Owner / Maintainer:** `@gatesccn`
> **Creador original del script:** Henry Chumo (`@ChumoGH`)

---

## ⚡ Instalación Rápida (Cliente Final)

**No necesitas abrir ningún puerto.** Solo tienes que generar tu key y ejecutar 1 comando.

### Paso 1 — Genera tu key (4 horas, 1 solo uso)

Abre en tu navegador o terminal:

```
https://chumoadmin.arcando.cloud/api-db.php?action=generate
```

Te devolverá algo así:

```json
{
  "success": true,
  "data": { "key": "LatamSRC--7DDCD89D4E0B2AC0", "status": "active", "ttl_hours": 4 }
}
```

> Copia la key (`LatamSRC--...`). **Se quema al instalar.**

### Paso 2 — Instala en tu VPS

**Opción A — Instalador ADM CGH (el normal):**
```bash
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/setup.sh -O setup.sh
chmod 777 setup.sh
./setup.sh --key LatamSRC--TU_KEY
```

**Opción B — Instalador LATAM:**
```bash
apt update -y; apt upgrade -y
wget -q https://chumoadmin.arcando.cloud/bash/latam.sh -O latam.sh
chmod 777 latam.sh
./latam.sh --key LatamSRC--TU_KEY
```

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

## 🔑 Keygen Central (solo para el Owner)

Los endpoints viven en tu VPS CyberPanel (`chumoadmin.arcando.cloud`):

| Acción | URL |
| :--- | :--- |
| Generar | `https://chumoadmin.arcando.cloud/api-db.php?action=generate` |
| Listar | `https://chumoadmin.arcando.cloud/api-db.php?action=list` |
| Verificar | `https://chumoadmin.arcando.cloud/api-db.php?action=check&key=LATAMSRC--...` |
| Consumir | `https://chumoadmin.arcando.cloud/api-db.php?action=consume&key=LATAMSRC--...` |

**Política:** key de 4 horas, 1 solo uso, se registra la IP que la consumió.

---

## 📡 ¿Qué endpoints usa el instalador?

Todo pasa por **HTTPS (443) saliente** hacia el dominio. **El cliente no abre nada de entrada.**

| Paso | Destino | Puerto |
| :--- | :--- | :--- |
| Verificar key | `chumoadmin.arcando.cloud/api-db.php` | 443 saliente |
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
