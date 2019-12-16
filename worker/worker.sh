#! /bin/sh

cd /var/www/html/jiyun && sudo -u www-data php artisan queue:listen --queue=default --tries=3
# cd /var/www/html/mes && php artisan queue:listen --queue=emails --tries=1

# tail -f /var/log/dmesg
