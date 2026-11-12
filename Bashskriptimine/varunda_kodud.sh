#!/bin/bash
# kodukataloogide varundamine
lahtekaust="/home"
sihtkaust="/home_bcp"
kuupaev=$(date +%d.%m.%Y)

mkdir -p "$sihtkaust"

# arhiveerimise käsud
for nimi in $(ls "$lahtekaust"); do
    if [ -d "$lahtekaust/$nimi" ]; then
        tar -czf "$sihtkaust/${nimi}.${kuupaev}.tar.gz" -C "$lahtekaust" "$nimi"
    fi
done
