#!/bin/bash

echo -n "Sisesta suvaline täisarv: "
read arv

# Kontrollime 2-ga jagamise jääki
if [ $((arv % 2)) -eq 0 ]; then
    echo "Antud arv on paaris"
else
    echo "Antud arv on paaritu"
fi
