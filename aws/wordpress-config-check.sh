#!/bin/bash

LOCAL_IP=$(curl ifconfig.me)
CONFIG_FILE="/etc/wordpress/config-$LOCAL_IP.php"

echo "Verificando la existencia del archivo de configuración para la IP $LOCAL_IP..."

if [ ! -f "$CONFIG_FILE" ]; then
    echo "El archivo $CONFIG_FILE no existe. Creándolo..."
    sudo cp /home/ubuntu/wordpress/config-localhost.php "$CONFIG_FILE"
else
    echo "El archivo $CONFIG_FILE ya existe. No se requieren cambios."
fi
sudo service apache2 restart
