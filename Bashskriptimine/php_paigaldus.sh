#!/bin/bash

# Kontrollime, kas php on paigaldatud
PHP=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c 'ok installed')

# Kui php ei ole veel paigaldatud
if [ "$PHP" -eq 0 ]; then
    echo "Paigaldame php ja vajalikud lisapaketid..."
    apt update
    apt install php libapache2-mod-php php-mysql -y
    systemctl restart apache2
    echo "php on paigaldatud."

# Kui php on juba paigaldatud
elif [ "$PHP" -eq 1 ]; then
    echo "php on juba paigaldatud."
    which php
    php -v
fi
