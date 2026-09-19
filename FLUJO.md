# FLUJO DE INSTALACIÓN - cghlatamsrc

**Owner:** @gatesccn | **Creador original:** Henry Chumo (@ChumoGH)
**Última actualización:** 19/09/2026

---

## 1. Resumen: ¿Qué scripts existen y cuál se usa?

Hay **2 instaladores** y **1 menú** y **1 capa 2 (pack)**. Aquí queda claro qué hace cada uno:

| Script | Rol | Se entrega al cliente? |
| :--- | :--- | :--- |
| `setup.sh` | **Instalador ADM CGH** (el normal, el de Chumo) | ✅ SÍ - es el principal |
| `latam.sh` | **Instalador LATAM** (variante autónoma) | ✅ SÍ - alternativa |
| `pack_new.sh` | Capa 2: lo descarga `setup.sh` e instala el ADM real | ❌ NO (interno) |
| `menu.sh` | El panel/menú final (9.466 líneas) | ❌ NO (interno) |
| `styles.cpp` | Motor gráfico `msg`/`print_center` | ❌ NO (interno) |

> **Regla:** Al cliente SOLO se le da 1 URL + 1 KEY. Nunca se le pasan los internos.

---

## 2. FLUJO A — Instalador `setup.sh` (ADM CGH)

```
[Cliente]  https://chumoadmin.arcando.cloud/bash/setup.sh  (o wget desde su VPS)
                              |
                              v
   setup.sh  --key LatamSRC--XXXX
       |
       |-- (1) VERIFICA KEY en el Keygen Central
       |        GET https://chumoadmin.arcando.cloud/api-db.php?action=consume&key=LATAMSRC--XXXX
       |        -> { success: true, ip: "<IP del cliente>" }
       |
       |-- (2) DESCARGA CAPA 2 (pack_new)
       |        https://chumoadmin.arcando.cloud/bash/pack_new.sh
       |                       |
       |                       v
       |            pack_new.sh (instala ADM real: /etc/adm-lite, /etc/ADMcgh, /bin/menu)
       |                       |
       |                       |-- baja toolmaster.py    desde GitHub raw
       |                       |-- baja add_new_user.bin desde GitHub raw
       |                       |-- baja plugin.html      desde GitHub raw (landing web)
       |                       |-- crea /bin/menu /bin/cgh /bin/adm
       |                       |-- crea /etc/adm-lite/menu (el panel)
       |
       |-- (3) DESCARGA MODULOS DEL MENU (lista-arq)
       |        https://chumoadmin.arcando.cloud/bash/modules/<archivo>
       |
       v
   [FIN] Escribir "menu" en la terminal -> panel instalado
```

---

## 3. FLUJO B — Instalador `latam.sh` (LATAM autónomo)

```
[Cliente]  wget https://chumoadmin.arcando.cloud/bash/latam.sh
           chmod 777 latam.sh && ./latam.sh
                              |
                              v
   latam.sh  (NO usa parámetro --key, pide la key en pantalla)
       |
       |-- (1) Instala el launcher /usr/bin/LATAM
       |-- (2) VERIFICA KEY (mismo Keygen Central)
       |        GET https://chumoadmin.arcando.cloud/api-db.php?action=consume&key=...
       |-- (3) Crea /etc/SCRIPT-LATAM/ (su propio directorio)
       |-- (4) Descarga sus módulos propios
       |-- (5) Escribe "menu" -> panel LATAM
```

> ⚠️ **Diferencia clave:** `latam.sh` es un script **independiente** con su propio menú (`menu.sh`) y su propio directorio (`/etc/SCRIPT-LATAM`). No usa `pack_new`. Los dos instaladores **no se mezclan**.

---

## 4. ¿El cliente necesita abrir algún puerto?

**NO.** Todo funciona así:

| Paso | Dirección | Puerto |
| :--- | :--- | :--- |
| Verificar/consumir key | Cliente → `chumoadmin.arcando.cloud` | 443 (HTTPS saliente) |
| Descargar pack_new | Cliente → `chumoadmin.arcando.cloud` | 443 (HTTPS saliente) |
| Descargar módulos | Cliente → `chumoadmin.arcando.cloud` | 443 (HTTPS saliente) |
| Panel web local | Cliente → su propia IP | 81 (nginx local, lo instala el pack) |

**El cliente NO necesita abrir nada de entrada.** Solo necesita salida HTTPS (443), que cualquier VPS tiene.

**El puerto 81** se abre **en la propia VPS del cliente** (lo hace `pack_new.sh` con nginx local) para servir su panel web. No es el 81 del keygen.

---

## 5. ¿Por qué ya no hay IPs fijas?

**Antes (MAL):** El `setup.sh` apuntaba a `http://<IP-FIJA>:81/...`
→ Si esa VPS se caía o cambiaba, **todas las instalaciones del mundo se rompían**.

**Ahora (BIEN):** Todo apunta al **dominio** `https://chumoadmin.arcando.cloud/...`
→ Cloudflare hace el proxy, así que:
- Si cambias de VPS, **solo actualizas el DNS de Cloudflare** y nada más se rompe.
- El dominio es estable, la IP es volátil.

**Único caso donde se usa `hostname -I`:** si el cliente necesita su propia IP local para algo temporal (ej: mostrar la IP en el banner del menú). Se obtiene con `hostname -I | awk '{print $1}'`, nunca hardcodeada.

---

## 6. Estructura del repositorio (limpia y ordenada)

```
cghlatamsrc/
├── README.md                  # Manual de uso (para cliente final)
├── FLUJO.md                   # Este archivo (diagrama técnico)
├── registrocambios.md         # Bitácora de avances
│
├── bash/                      # ★ LO QUE SE SUBE A MI VPS CIBERPANEL
│   ├── setup.sh               #   instalador ADM CGH
│   ├── latam.sh               #   instalador LATAM
│   ├── pack_new.sh            #   capa 2 (interno, lo llama setup.sh)
│   ├── pack3.sh               #   capa 2 fallback
│   ├── menu.sh                #   el panel final (interno)
│   └── styles.cpp             #   motor msg (interno)
│
└── audit/                     # ★ SOLO ANÁLISIS (no producción)
    ├── desofuscadores/        #   herramientas Python
    └── originales/            #   volcados originales sin tocar
```

**Regla:** en `bash/` solo lo que va a producción; en `audit/` solo análisis.
