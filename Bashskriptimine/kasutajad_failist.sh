#!/bin/bash

if [ -z "$1" ]; then
    echo "Viga: Failinimi on puudu!"
    echo "Kasutamine: sh $0 kasutajate_fail"
    exit 1
fi

FAIL="$1"

# Loeme faili rida-realt ja lisame kasutajad, käivitades eelmise skripti
while IFS= read -r kasutaja; do
    # Kontrollime, et rida poleks tühi
    if [ -n "$kasutaja" ]; then
        sh lisa_kasutaja "$kasutaja"
    fi
done < "$FAIL"
