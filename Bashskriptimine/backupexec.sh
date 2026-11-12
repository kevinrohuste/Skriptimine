#!/bin/bash
# automaatne varundusskript
set -euo pipefail

BASE_DIR="$HOME/praks2"
SRC_DIR="$BASE_DIR/src"
BACKUP_DIR="$BASE_DIR/backup"
LOG_FILE="$BASE_DIR/logs/backup.log"
IGNORE_FILE="$SRC_DIR/.backupignore"

mkdir -p "$BACKUP_DIR" "$BASE_DIR/logs"

# ajutine kaust
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

logi() {
    echo "[$(date '+%F %T')] $1" | tee -a "$LOG_FILE"
}

logi "BACKUP START"

# vaba ruumi kontroll
SRC_SIZE=$(du -sb "$SRC_DIR" | awk '{print $1}')
FREE_SPACE=$(df -B1 "$BACKUP_DIR" | awk 'NR==2{print $4}')
[ "$FREE_SPACE" -lt "$SRC_SIZE" ] && { logi "VIGA: vähe ruumi"; exit 1; }

# kompressori valik
if command -v zstd >/dev/null 2>&1; then
    EXT="tar.zst"; COMP=(-I "zstd -19 -T0"); DECOMP=(-I "zstd -d")
elif command -v xz >/dev/null 2>&1; then
    EXT="tar.xz"; COMP=(-J); DECOMP=(-J)
else
    EXT="tar.gz"; COMP=(-z); DECOMP=(-z)
fi

ARCHIVE="src_$(date +%F_%H-%M-%S).${EXT}"
EXCL=()
[ -f "$IGNORE_FILE" ] && EXCL=(--exclude-from="$IGNORE_FILE")

# arhiveerimise käsud
tar "${EXCL[@]}" "${COMP[@]}" -cf "$TMP_DIR/$ARCHIVE" -C "$BASE_DIR" "src"
tar "${DECOMP[@]}" -tf "$TMP_DIR/$ARCHIVE" | grep -q "src/"

# SHA-256 kontroll
mv "$TMP_DIR/$ARCHIVE" "$BACKUP_DIR/$ARCHIVE"
(cd "$BACKUP_DIR" && sha256sum "$ARCHIVE" > "${ARCHIVE}.sha256" && sha256sum -c "${ARCHIVE}.sha256")

logi "EDUKAS: $ARCHIVE ($(du -h "$BACKUP_DIR/$ARCHIVE" | awk '{print $1}'))"

# hoia alles 3 viimast koopiat
(cd "$BACKUP_DIR" && ls -1t src_*.tar.* 2>/dev/null | grep -v '\.sha256$' | tail -n +4 | xargs -r -I{} rm -f "{}" "{}.sha256")

logi "BACKUP END"
