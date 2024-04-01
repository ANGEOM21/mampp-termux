pkg install php php-apache apache2 mariadb -y
chmod +x conf
mv -f conf/php $HOME
rm -r $PREFIX/etc/apache2/httpd.conf
mv -f conf/httpd.conf $PREFIX/etc/apache2
mv -f conf/php_module.conf $PREFIX/etc/apache2/extra
chmod 600 $PREFIX/etc/apache2/httpd.conf
chmod 644 $PREFIX/etc/apache2/extra/php_module.conf
unzip $HOME/php/htdocs/phpmyadmin.zip
rm -r $HOME/php/htdocs/phpmyadmin.zip
chmod 660 $HOME/php/htdocs/phpmyadmin/config.inc.php





