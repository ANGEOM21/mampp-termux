# Xampp - Termux v.0.0.3
## Apache, Mysql, Mariadb, PHP, PhpMyAdmin

## Feature

- XAMPP DI TERMUX TANPA CONFIGURASI LAGI

## Tech

* [TERMUX](https://learn.microsoft.com/id-id/powershell/](https://termux.dev/en/ ) - Termux is an Android terminal emulator and Linux environment app that works directly with no rooting or setup required. A minimal base system is installed automatically - additional packages are available using the APT package manager.

* [PHP](https://www.php.net/) - popular general-purpose scripting language that is especially suited to web development.

* [APACHE](https://www.apachefriends.org/download.html](https://httpd.apache.org/ ) - The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards..

* MARIADB]([https://mariadb.org/documentation/)) - The primary place for MariaDB Server specific documentation is the MariaDB Server Knowledge Base.

* [PHPMYADMIN](https://www.phpmyadmin.net/ ) - phpMyAdmin is a free software tool written in PHP, intended to handle the administration of MySQL over the Web. phpMyAdmin supports a wide range of operations on MySQL and MariaDB. Frequently used operations (managing databases, tables, columns, relations, indexes, users, permissions, etc) can be performed via the user interface, while you still have the ability to directly execute any SQL statement.

## Requirement

* Apache 2.4
* PHP 8.2.0
* PHPMYADMIN 4.9.11
* Mariadb 11.3.0

## Structure

```
📦Xampp-termux
 ┣ 📂conf
 ┃ ┗ 📂php/htdocs
 ┃ ┣ 📜httpd.conf
 ┃ ┣ 📜php_module.conf
 ┗ 📜configure.sh
```
## installation

Pastikan Sudah Menginstall Termux [disini](https://drive.google.com/file/d/17P5y-IKhXcWPfc8lp5s0LQH3hvZOlKgQ/view?usp=drive_link )
Buka Aplikasi Termux nya 

* lalu jalankan seperti ini

1. ``` apt update && apt upgrade -y ```
NB: jika ada perintah tekan saja y / Y

* jika selesai lanjut perintah berikut :

2. ``` pkg install git -y ```

3.  ``` git clone https://github.com/ANGEOM21/mampp-termux.git ```

NB: jika menggunkan git harap install dulu gh ``` pkg install gh -y ``` dan lakukan login github
disarankan mendowload zip

4. ``` cd mampp-termux ```

5. ``` ./configure.sh ```

* jika sudah selesai semuanya jalanakan perintah berikut
```
apachectl
```
* lalu buka localhost:8080
* jika ingin membuka phpmyadmin jalankan dulu perintah berikut
```
mysqld_safe
```
* buka localhost:8080/phpmyadmin
  
### NB:

terdapat htdocs di dalam folder php yang berada di home termux nya jika ingin mengetahui 
```
cd php/htdocs
```
tambahkan folder yang ingin anda buat dan anda sudah bisa menjalankan seperti xampp di Laptop atau pc di Handphone melalui Termux 

jika ingin apk editor nya dan terhubung ke termux bisa commentar atau hubungi di sosial media yang di bawah
nanti akan di buatkan 
### selamat 😊

* CREDITS

* [ancode__](https://www.instagram.com/ancode__/) - My INSTAGRAM
