#!/bin/bash
# kodukataloogide varundamine

lahtekaust="${1:-/home}"
sihtkaust="/home_bcp"
kuupaev=$(date +%d.%m.%Y)

if [ ! -d "$lahtekaust" ]; then
    echo "Viga: kausta $lahtekaust ei leitud"
    exit 1
fi

mkdir -p "$sihtkaust"

for tee in "$lahtekaust"/*; do
    [ -e "$tee" ] || continue
    nimi=$(basename "$tee")
    if [ -d "$tee" ]; then
        echo "Varundan: $nimi"
        # arhiveerimise käsud
        tar -czf "${sihtkaust}/${nimi}.${kuupaev}.tar.gz" -C "$lahtekaust" "$nimi"
    fi
done
