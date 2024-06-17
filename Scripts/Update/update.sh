#!/bin/bash
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
baseDIR="${updateDIR%/Scripts/Update}"
parentDIR="$(dirname "$baseDIR")"

find "$baseDIR" -xdev -depth ! \( -name . -or -name "update.sh" \) -exec rm -df {} +

git clone --depth 1 "https://github.com/qiitaqiitaykuyo/Minecraft-bedrock-server_Backup-by-Git..git" "$baseDIR/minecraft.git"
cd "$baseDIR"
\cp -fR --parents "minecraft.git" "$parentDIR"

find "$baseDIR" -type f -name "update_2.sh" -exec bash -- {} +

