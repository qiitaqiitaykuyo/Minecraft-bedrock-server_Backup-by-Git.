#!/bin/bash
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
baseDIR="${updateDIR%/Scripts/Update}"

echo "$updateDIR"
echo "$baseDIR"

find "$baseDIR" -xdev -depth ! -name "update.sh" -and ! -name "minecraft.git" -exec rm -df {} +

git clone --depth 1 "https://github.com/qiitaqiitaykuyo/Minecraft-bedrock-server_Backup-by-Git..git" "$baseDIR/.minecraft.git"

\cp -TRf "$baseDIR/.minecraft.git" "$baseDIR"

find "$baseDIR" -type f -name "update_2.sh" -exec bash -- {} +

echo -n $'\n'
