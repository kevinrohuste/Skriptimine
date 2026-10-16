#!/bin/bash

if [ -z "$1" ]; then
    echo "Viga: Failinimi on puudu!"
    echo "Kasutamine: sh $0 kasutajad_paroolid_fail"
    exit 1
fi

FAIL="$1"

while IFS=: read -r kasutaja parool; do
    if [ -n "$kasutaja" ] && [ -n "$parool" ]; then
        useradd -m "$kasutaja"
        echo "$kasutaja:$parool" | chpasswd
        echo "Kasutaja $kasutaja lisatud parooliga."
    fi
done < "$FAIL"
