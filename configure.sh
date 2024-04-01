#!/bin/bash

# Installasi paket yang diperlukan
echo "Memulai instalasi paket..."
pkg install php php-apache apache2 mariadb -y

# Mengatur konfigurasi PHP dan Apache
echo "Mengatur konfigurasi..."
chmod +x conf
mv -f conf/php $HOME
rm -r $PREFIX/etc/apache2/httpd.conf
mv -f conf/httpd.conf $PREFIX/etc/apache2
mv -f conf/php_module.conf $PREFIX/etc/apache2/extra
chmod 600 $PREFIX/etc/apache2/httpd.conf
chmod 644 $PREFIX/etc/apache2/extra/php_module.conf

# Mengekstrak phpMyAdmin
echo "Mengekstrak phpMyAdmin..."
unzip $HOME/php/htdocs/phpmyadmin.zip -d $HOME/php/htdocs/
rm -r $HOME/php/htdocs/phpmyadmin.zip
chmod 660 $HOME/php/htdocs/phpmyadmin/config.inc.php

# Membersihkan layar
clear

# Menampilkan pesan bahwa konfigurasi selesai
echo "Konfigurasi telah selesai!"
echo "Silakan jalankan perintah berikut untuk menghidupkan layanan:"
echo "- apachectl untuk menghidupkan Apache"
echo "- mysqld_safe untuk menghidupkan MySQL"
echo ""
echo "server berjalan di http://localhost:8080/"
echo "phpmyadmin di http://localhost:8080/phpmyadmin"
