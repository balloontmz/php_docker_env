#! /bin/sh

cd /var/www/html/onshopway-api && php artisan queue:listen --queue=gather,goods --tries=3
# cd /var/www/html/mes && php artisan queue:listen --queue=emails --tries=1

# tail -f /var/log/dmesg
