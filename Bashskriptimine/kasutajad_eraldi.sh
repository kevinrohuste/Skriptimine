#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Viga: Vaja on kahte faili!"
    echo "Kasutamine: sh $0 kasutajate_fail paroolide_fail"
    exit 1
fi

KASUTAJAD_FAIL="$1"
PAROOLID_FAIL="$2"

# Kasutame paste käsku, et ühendada kahe faili read kooloniga, ja siis loeme
paste -d: "$KASUTAJAD_FAIL" "$PAROOLID_FAIL" | while IFS=: read -r kasutaja parool; do
    if [ -n "$kasutaja" ] && [ -n "$parool" ]; then
        useradd -m "$kasutaja"
        echo "$kasutaja:$parool" | chpasswd
        echo "Kasutaja $kasutaja lisatud."
    fi
done
