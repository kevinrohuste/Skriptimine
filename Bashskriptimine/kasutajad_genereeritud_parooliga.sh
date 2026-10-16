#!/bin/bash

# Ülesanne 6: Kontrollime, kas skripti käivitaja on root
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: Seda skripti peab käivitama root kasutajana!"
    exit 1
fi

if [ -z "$1" ]; then
    echo "Viga: Kasutajate failinimi on puudu!"
    echo "Kasutamine: ./$0 kasutajate_fail"
    exit 1
fi

FAIL="$1"
LOGIFAIL="loodud_kasutajad_paroolidega.txt"

# Kontrollime pwgen olemasolu ja paigaldame, kui puudub
if ! command -v pwgen &> /dev/null; then
    echo "pwgen puudub, paigaldame..."
    apt-get update && apt-get install -y pwgen
fi

# Tühjendame eelmise logifaili (kui on olemas)
> "$LOGIFAIL"

while IFS= read -r kasutaja; do
    if [ -n "$kasutaja" ]; then
        # Genereerime 8-tähelise parooli
        parool=$(pwgen -0 -A 8 1)
        
        # Loome kasutaja ja määrame parooli
        useradd -m "$kasutaja"
        echo "$kasutaja:$parool" | chpasswd
        
        # Kirjutame andmed logifaili
        echo "$kasutaja:$parool" >> "$LOGIFAIL"
        echo "Kasutaja $kasutaja lisatud genereeritud parooliga."
    fi
done < "$FAIL"

echo "Töö tehtud! Vaata paroole failist: $LOGIFAIL"
