#! /bin/sh
cd /var/www/html/kean && sudo -u www-data php artisan queue:listen --queue=kean_goods,kean_order --tries=3

