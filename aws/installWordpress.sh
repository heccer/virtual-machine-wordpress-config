#Instalar paquetes principales
echo "Instalando paquetes principales..."
sudo apt-get update && sudo apt-get install -y apache2 php mysql-server wordpress

#Crear la base de datos de Wordpress
echo "Creando base de datos wordpress en mysql..."
cat wordpress.sql | sudo mysql --defaults-extra-file=/etc/mysql/debian.cnf

#Copiar el archivo host de apache  para wordpress
echo "Copiando archivo de configuracion web de wordpress en /etc/apache2/sites-available/..."
sudo cp wordpress.conf /etc/apache2/sites-available/

#Copiar el archivo de configuracion php de wordpress
echo "Copiando archivo de configuracion base de wordpress en /etc/wordpress/..."

PUBLIC_IP=$(curl ifconfig.me)
echo "La IP del servidor es: $PUBLIC_IP | Creando el archivo /etc/wordpress/config-$PUBLIC_IP.php..."
sudo cp config-localhost.php /etc/wordpress/config-$PUBLIC_IP.php

#Crear el link simbolico para indicar un sitio habilitado de wordpress
echo "Creando link simbolico del aplicativo web worpdress..."
sudo ln -s /etc/apache2/sites-available/wordpress.conf /etc/apache2/sites-enabled/

#Reiniciar apache con la configuracion realizada
echo "Reiniciando apache..."
sudo service apache2 restart

echo "Listo! revisar el wizard de arranque en http://$PUBLIC_IP/blog"
