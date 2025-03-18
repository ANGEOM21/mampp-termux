#!/bin/bash

# Fungsi untuk menampilkan pesan dengan warna hijau
function print_progress {
    echo -e "\e[1;32m$1\e[0m"
}

clear
print_progress "Sedang menginstall... Mohon tunggu!"

# Tentukan direktori conf berdasarkan lokasi skrip saat ini
CONF_DIR="$(pwd)/conf"

# Pastikan direktori conf ada
if [ ! -d "$CONF_DIR" ]; then
    echo "⚠ Direktori $CONF_DIR tidak ditemukan!"
    exit 1
fi

# Instalasi paket secara berurutan
print_progress "Menginstall paket yang diperlukan..."
pkg install -y php php-apache apache2 mariadb phpmyadmin toilet > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "❌ Gagal menginstall paket! Periksa koneksi internet dan coba lagi."
    exit 1
fi

print_progress "Mengatur konfigurasi PHP dan Apache..."
chmod +x "$CONF_DIR"
mv -f "$CONF_DIR/php" $HOME > /dev/null 2>&1

# Hapus konfigurasi Apache lama jika ada
if [ -f "$PREFIX/etc/apache2/httpd.conf" ]; then
    rm -r $PREFIX/etc/apache2/httpd.conf > /dev/null 2>&1
fi

# Pindahkan konfigurasi baru
mv -f "$CONF_DIR/httpd.conf" $PREFIX/etc/apache2 > /dev/null 2>&1
mv -f "$CONF_DIR/php_module.conf" $PREFIX/etc/apache2/extra > /dev/null 2>&1
chmod 600 $PREFIX/etc/apache2/httpd.conf
chmod 644 $PREFIX/etc/apache2/extra/php_module.conf

# Menyiapkan phpMyAdmin
print_progress "Menyiapkan phpMyAdmin..."

# Pastikan direktori tujuan ada
mkdir -p $HOME/php/htdocs

# Buat symlink phpMyAdmin ke dalam htdocs jika belum ada
if [ ! -L "$HOME/php/htdocs/phpmyadmin" ]; then
    ln -s $PREFIX/share/phpmyadmin $HOME/php/htdocs/phpmyadmin
    print_progress "✅ Symlink phpMyAdmin berhasil dibuat."
else
    print_progress "✅ Symlink phpMyAdmin sudah ada."
fi

# Replace config.inc.php dengan yang ada di folder conf
if [ -f "$CONF_DIR/config.inc.php" ]; then
    cp -f "$CONF_DIR/config.inc.php" $HOME/php/htdocs/phpmyadmin/config.inc.php
    chmod 660 $HOME/php/htdocs/phpmyadmin/config.inc.php
    print_progress "✅ Konfigurasi phpMyAdmin berhasil diperbarui."
else
    echo "⚠ File config.inc.php tidak ditemukan di folder $CONF_DIR!"
fi

# Menyiapkan script start-server dan stop-server
print_progress "Menyiapkan server..."

if [ -f "$CONF_DIR/start-server" ]; then
    mv -f "$CONF_DIR/start-server" $PREFIX/bin/start-server
    chmod +x $PREFIX/bin/start-server
    print_progress "✅ Script start-server berhasil dipindahkan."
else
    echo "⚠ start-server tidak ditemukan di folder $CONF_DIR!"
fi

if [ -f "$CONF_DIR/stop-server" ]; then
    mv -f "$CONF_DIR/stop-server" $PREFIX/bin/stop-server
    chmod +x $PREFIX/bin/stop-server
    print_progress "✅ Script stop-server berhasil dipindahkan."
else
    echo "⚠ stop-server tidak ditemukan di folder $CONF_DIR!"
fi

# Membersihkan layar dan menampilkan pesan akhir
clear
print_progress "✅ Konfigurasi telah selesai!"
print_progress "Silakan jalankan perintah berikut untuk menghidupkan layanan:"
print_progress "- start-server untuk menjalankan server"
print_progress "- stop-server untuk menghentikan server"

echo ""
print_progress "🌐 Server berjalan di: http://localhost:8080/"
print_progress "📌 Database di: http://localhost:8080/phpmyadmin"