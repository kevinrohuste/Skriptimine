#!/bin/bash

AJUTINE_FAIL=$(mktemp)
trap 'rm -f "$AJUTINE_FAIL"' EXIT


loendur=0
while [ "$loendur" -lt 5 ]; do

    number=$(( RANDOM % 50 + 1 ))

    if ! grep -qx "$number" "$AJUTINE_FAIL"; then
        echo "$number" >> "$AJUTINE_FAIL"
        loendur=$(( loendur + 1 ))
    fi
done

AEG=$(date '+%Y-%m-%d %H:%M:%S')
NUMBRID=$(tr '\n' ' ' < "$AJUTINE_FAIL" | xargs)
TULEMUS="[$AEG] Genereeritud numbrid: $NUMBRID"

echo "Kuhu soovite tulemuse väljastada?"
echo "1) Terminali (stdout)"
echo "2) Salvesta faili"
read -rp "Tehke valik (1 või 2): " valik

if [ "$valik" = "2" ]; then
    read -rp "Sisestage faili nimi [tulemused.txt]: " failinimi
    failinimi=${failinimi:-tulemused.txt}

    echo "$TULEMUS" >> "$failinimi"
    echo "Tulemus salvestatud faili '$failinimi'."
else
    echo -e "\n$TULEMUS"
fi
