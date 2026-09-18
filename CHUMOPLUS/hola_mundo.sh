#!/usr/bin/env bash
# Script de bienvenida y prueba segura en Windows
set -euo pipefail

echo "=========================================="
echo "         ¡Hola Mundo desde Bash!          "
echo "=========================================="
echo "Directorio actual : $(pwd)"
echo "Usuario           : $(whoami)"
echo "Versión de Bash   : $BASH_VERSION"
echo "Fecha y hora      : $(date)"
echo "=========================================="
echo "Estado: Ejecución exitosa y segura."
