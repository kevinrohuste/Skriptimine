#!/bin/bash

# Määrame kausta, kus arhiivid reaalselt asuvad
KAUST="$HOME/praks2/backup"

# Liigume arhiivide kausta, et vältida "No such file or directory" viga
cd "$KAUST" || { echo "Viga: Kausta $KAUST ei leitud!"; exit 1; }

echo "=== Töötan kaustas: $KAUST ==="
echo "=== Uusima arhiivi kontrollsumma loomine ==="

# Leiame kõige uuema arhiivi
ARCHIVE="$(ls -1t src_*.tar.zst 2>/dev/null | head -n1)"

# Kontrollime, kas fail leiti
if [ -z "$ARCHIVE" ]; then
    echo "Viga: Ühtegi 'src_*.tar.zst' faili ei leitud kaustas $KAUST!"
    exit 1
fi

echo "Arvutan kontrollsumma failile: $ARCHIVE"
sha256sum "$ARCHIVE" > "$ARCHIVE.sha256"

echo -e "\n=== Äsja loodud summa kontroll ==="
sha256sum -c "$ARCHIVE.sha256"

echo -e "\n=== Kõigi arhiivide ühise nimekirja loomine (checksums.txt) ==="
find . -maxdepth 1 -type f -name 'src_*.tar.*' -print0 | xargs -0 sha256sum > checksums.txt
echo "Nimekiri checksums.txt on loodud!"

echo -e "\n=== Kõigi arhiivide ühiskontroll ==="
sha256sum -c checksums.txt
