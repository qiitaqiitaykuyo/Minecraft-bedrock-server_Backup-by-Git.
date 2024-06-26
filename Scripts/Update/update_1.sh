#!/bin/bash -u
set -o nounset

updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
baseDIR="${updateDIR%/Scripts/Update}"
dirNAME="$(basename "$baseDIR")"

echo -n $'\n'
echo "$baseDIR"

if [[ -v baseDIR ]]; then
  find "$baseDIR" -xdev -depth ! -name "update.sh" -and ! -name "$dirNAME" -exec rm -df {} +
fi

git clone --depth 1 "https://github.com/qiitaqiitaykuyo/Minecraft-bedrock-server_Backup-by-Git..git" "$baseDIR/.minecraft.git"

\cp -TRf "$baseDIR/.minecraft.git" "$baseDIR"

find "$baseDIR" -type f -name "update_2.sh" -exec bash -- {} +

