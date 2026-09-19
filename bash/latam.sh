#!/bin/bash
export TERM="${TERM:-xterm-256color}"
# ==============================================================================
# LATAM_latamsrc.sh - Instalador Alternativo Línea LATAM / NetVPS
# Autor: @gatesccn / @SNIPER754186
# Repositorio: https://github.com/SNIPER754186/cghlatamsrc
# Keygen API: https://chumoadmin.arcando.cloud/api-db.php
# ==============================================================================

set -o pipefail
export DEBIAN_FRONTEND=noninteractive
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/

# 1. Parsear argumentos
# Parser de argumentos: acepta --key <KEY>, --Latam, --latam, --ADMcgh, -k <KEY>
KEY_PARAM=""
MODE_PARAM=""
TEMP_ARGS=("$@")
for ((i=0; i<${#TEMP_ARGS[@]}; i++)); do
    case "${TEMP_ARGS[i]}" in
        --key|-k)  KEY_PARAM="${TEMP_ARGS[i+1]}"; ((i++)) ;;
        --Latam|--latam) MODE_PARAM="latam" ;;
        --ADMcgh|--admcgh) MODE_PARAM="admcgh" ;;
        LatamSRC--*) KEY_PARAM="${TEMP_ARGS[i]}" ;;
    esac
done

# 2. Verificar root
if [[ $(id -u) -ne 0 ]]; then
    echo -e "\033[1;31m [!] Este script debe ejecutarse como root (sudo -i)\033[0m"
    exit 1
fi

# 3. Verificar generador oficial autorizado
# La validacion de la key la hace el Keygen Central (api-db.php). No hay IPs fijas aqui.

# 4. Solicitar o procesar la Key
clear
echo -e "\033[1;34m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;37m        INSTALADOR ADM | VARIANTE LATAM-NETVPS      \033[0m"
echo -e "\033[1;34m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;37m  Genera tu key en: \033[1;36mhttps://t.me/chumodgatesccn_Bot\033[0m"
echo -e " Servidor Keygen:  \033[1;36mchumoadmin.arcando.cloud (CyberPanel SQL)\033[0m"
echo -e "\033[1;34m────────────────────────────────────────────────────\033[0m"

clean_input="$KEY_PARAM"
if [[ -z "$clean_input" ]]; then
    read -p "$(echo -e " \033[1;44m PEGA TU KEY LATAM : \033[0m ")" clean_input
fi

if [[ -z "$clean_input" ]]; then
    echo -e "\033[1;31m [!] No se introdujo ninguna key. Abortando.\033[0m"
    exit 1
fi

# 5. Validar y Consumir en CyberPanel SQL
API_ENDPOINT="https://chumoadmin.arcando.cloud/api-db.php"
if [[ "$clean_input" == "latamsrcddev" ]]; then
    echo -e "\033[1;32m [✔] MASTER DEV KEY AUTORIZADA\033[0m"
    KEY_CREATOR="@gatesccn"
else
    echo -ne "\033[1;33m [*] Validando key en CyberPanel SQL...\033[0m "
    CONSUME_RAW=$(curl -sSL --connect-timeout 15 "${API_ENDPOINT}?action=consume&key=${clean_input}")
    IS_OK=$(echo "$CONSUME_RAW" | jq -r '.success' 2>/dev/null || python3 -c "import json,sys; d=json.loads(sys.argv[1]); print(str(d.get('success','')).lower())" "$CONSUME_RAW" 2>/dev/null)

    if [[ "$IS_OK" == "true" ]]; then
        echo -e "\033[1;32m[DONE]\033[0m"
        KEY_CREATOR=$(echo "$CONSUME_RAW" | jq -r '.creator // empty' 2>/dev/null || python3 -c "import json,sys; d=json.loads(sys.argv[1]); print(d.get('creator',''))" "$CONSUME_RAW" 2>/dev/null)
        [[ -z "$KEY_CREATOR" || "$KEY_CREATOR" == "null" ]] && KEY_CREATOR="@gatesccn"
        echo -e " \033[1;32m✔ Key consumida exitosamente para esta VPS.\033[0m"
        echo -e " \033[1;36m✔ Vendedor / Reseller: ${KEY_CREATOR}\033[0m"
    else
        echo -e "\033[1;31m[FAIL]\033[0m"
        ERR_MSG=$(echo "$CONSUME_RAW" | jq -r '.message' 2>/dev/null || echo "Key rechazada")
        ERR_IP=$(echo "$CONSUME_RAW" | jq -r '.used_by_ip' 2>/dev/null || echo "")
        ERR_AT=$(echo "$CONSUME_RAW" | jq -r '.used_at' 2>/dev/null || echo "")
        echo -e "\n\033[1;31m════════════════════════════════════════════════════\033[0m"
        echo -e "\033[1;31m [!] ERROR: ${ERR_MSG}\033[0m"
        [[ -n "$ERR_IP" && "$ERR_IP" != "null" ]] && echo -e "\033[1;33m     Consumida por IP : ${ERR_IP}\033[0m"
        [[ -n "$ERR_AT" && "$ERR_AT" != "null" ]] && echo -e "\033[1;33m     Fecha de consumo : ${ERR_AT}\033[0m"
        echo -e "\033[1;31m════════════════════════════════════════════════════\033[0m"
        echo -e " Genera tu key en: \033[1;36mhttps://chumoadmin.arcando.cloud\033[0m\n"
        exit 1
    fi
fi

# 6. Despliegue de estructura de directorios
SCPdir="/etc/SCRIPT-LATAM"
SCPinstal="$HOME/install_latam"
mkdir -p ${SCPdir} ${SCPinstal} /bin/ejecutar

# Guardar llaves y vendedor
echo "$clean_input" > ${SCPdir}/key.txt
echo "$clean_input" > /etc/cghkey
echo "$clean_input | chumoadmin.arcando.cloud | $(hostname -I 2>/dev/null | awk '{print $1}')" > /etc/chekKEY

# 7. Descargar modulos
echo -e "\n\033[1;33m [*] Descargando modulos del sistema LATAM...\033[0m"
cat << 'LISTA_EOF' > $HOME/lista-arq
cabecalho
menu
menu_credito
v-local.log
payloads
http-server.py
ultrahost
shadowsocks.sh
PDirect.py
PGet.py
POpen.py
PPriv.py
PPub.py
LISTA_EOF

RAW_MODULES="https://raw.githubusercontent.com/SNIPER754186/cghlatamsrc/main/bash/modules"
for arqx in $(cat $HOME/lista-arq); do
    # CyberPanel primero (si existe /bash/modules/) y si no, GitHub raw del repo
    wget --no-check-certificate -q --tries=1 --timeout=12 -O "${SCPdir}/${arqx}" "https://${KEYGEN_DOMAIN:-chumoadmin.arcando.cloud}/bash/modules/${arqx}"
    [[ ! -s "${SCPdir}/${arqx}" ]] && wget --no-check-certificate -q --tries=1 --timeout=12 -O "${SCPdir}/${arqx}" "${RAW_MODULES}/${arqx}"
    chmod +x "${SCPdir}/${arqx}" 2>/dev/null || true
done

# Escribir creditos/llaves DESPUES de bajar modulos (para que no los pisen)
echo "$KEY_CREATOR" > ${SCPdir}/menu_credito
echo "$KEY_CREATOR" > /bin/ejecutar/menu_credito
echo "chumoadmin.arcando.cloud" > /usr/bin/vendor_code
rm -f $HOME/lista-arq

# 7b. Archivos de estado que el menu espera (en AMBAS rutas: LATAM y ADM)
mkdir -p /bin/ejecutar /etc/adm-lite
echo "0" > /bin/ejecutar/uskill
echo "V2.5.0" > /etc/SCRIPT-LATAM/v-local.log
echo "V2.5.0" > /etc/adm-lite/v-local.log      # el menu busca aqui tambien
echo "V2.5.0" > /bin/ejecutar/v-new.log
echo "Verified ${KEY_CREATOR}" > /bin/ejecutar/exito
echo "$KEY_CREATOR" > /bin/ejecutar/menu_credito
echo "$KEY_CREATOR" > /etc/adm-lite/menu_credito
MYIP="$(hostname -I 2>/dev/null | awk '{print $1}')"
echo "${MYIP}" > /bin/ejecutar/IPcgh
echo "${MYIP}" > /etc/adm-lite/name 2>/dev/null || true

# 8. Wrappers ejecutables de menu
cat << 'WRAP_EOF' > /usr/bin/menu
#!/bin/bash
cd /etc/SCRIPT-LATAM && ./menu
WRAP_EOF
chmod +x /usr/bin/menu
cp -f /usr/bin/menu /usr/bin/MENU
cp -f /usr/bin/menu /bin/menu 2>/dev/null || true

# 9. Copiar landing page oficial
[[ -f /root/bylatamsrc.html ]] && cp -f /root/bylatamsrc.html /var/www/html/index.html 2>/dev/null || true

# 10. Finalización limpia sin matar la sesión ni reiniciar
rm -rf ${SCPinstal}
echo -e "\n\033[1;32m════════════════════════════════════════════════════\033[0m"
echo -e "\033[1;32m [✔] INSTALACION LATAM NETVPS FINALIZADA CON EXITO!\033[0m"
echo -e "\033[1;32m════════════════════════════════════════════════════\033[0m"
echo -e " Escribe \033[1;33mmenu\033[0m para acceder al panel."
echo -e "\033[1;34m────────────────────────────────────────────────────\033[0m"
