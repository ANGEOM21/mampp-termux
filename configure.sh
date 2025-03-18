#!/bin/bash

# Fungsi untuk menampilkan pesan dengan efek warna hijau
function print_progress {
    echo -e "\e[1;32m$1\e[0m"
}

clear

print_progress "Sedang menginstall... Mohon tunggu!"

# Installasi paket di latar belakang
(
    pkg install php php-apache apache2 mariadb phpmyadmin toilet -y > /dev/null 2>&1
) &

# Animasi loading sementara instalasi berjalan
while pgrep -x "dpkg" > /dev/null; do
    echo -n "." 
    sleep 1
done
echo ""

# Mengatur konfigurasi PHP dan Apache
print_progress "Mengatur konfigurasi..."
chmod +x conf
mv -f conf/php $HOME > /dev/null 2>&1
rm -r $PREFIX/etc/apache2/httpd.conf > /dev/null 2>&1
mv -f conf/httpd.conf $PREFIX/etc/apache2 > /dev/null 2>&1
mv -f conf/php_module.conf $PREFIX/etc/apache2/extra > /dev/null 2>&1
chmod 600 $PREFIX/etc/apache2/httpd.conf
chmod 644 $PREFIX/etc/apache2/extra/php_module.conf

# Menyiapkan phpMyAdmin
print_progress "Menyiapkan phpMyAdmin..."

# Pastikan direktori tujuan ada
mkdir -p $HOME/php/htdocs

# Buat symlink phpMyAdmin ke dalam htdocs
if [ ! -L "$HOME/php/htdocs/phpmyadmin" ]; then
    ln -s $PREFIX/share/phpmyadmin $HOME/php/htdocs/phpmyadmin
    echo "Symlink phpMyAdmin berhasil dibuat."
else
    echo "Symlink phpMyAdmin sudah ada."
fi

# Replace config.inc.php dengan yang ada di folder conf
if [ -f "conf/config.inc.php" ]; then
    cp -f conf/config.inc.php $HOME/php/htdocs/phpmyadmin/config.inc.php
    chmod 660 $HOME/php/htdocs/phpmyadmin/config.inc.php
    echo "Konfigurasi phpMyAdmin berhasil diperbarui."
else
    echo "File config.inc.php tidak ditemukan di folder conf!"
fi

# Memindahkan start-server dan stop-server ke bin path
print_progress "Menyiapkan server."

if [ -f "conf/start-server" ]; then
    mv -f conf/start-server $PREFIX/bin/start-server
    chmod +x $PREFIX/bin/start-server
    echo "start-server berhasil di tambahkan"
else
    echo "start-server tidak ditemukan di folder conf!"
fi

if [ -f "conf/stop-server" ]; then
    mv -f conf/stop-server $PREFIX/bin/stop-server
    chmod +x $PREFIX/bin/stop-server
    echo "stop-server berhasil di tambahkan"
else
    echo "stop-server tidak ditemukan di folder conf!"
fi

# Membersihkan layar
clear

# Menampilkan pesan bahwa konfigurasi telah selesai
print_progress "Konfigurasi telah selesai!"
print_progress "Silakan jalankan perintah berikut untuk menghidupkan layanan:"
print_progress "- start-server untuk menjalankan server"
print_progress "- stop-server untuk menghentikan server"

echo ""
print_progress "Server berjalan di: http://localhost:8080/"
print_progress "Database di: http://localhost:8080/phpmyadmin"