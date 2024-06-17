#!/bin/bash
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
echo "$updateDIR"
echo "${updateDIR%/Scripts/Update}"
git clone --depth 1 "https://github.com/qiitaqiitaykuyo/Minecraft-bedrock-server_Backup-by-Git..git" "${updateDIR%/Scripts/Update}"
echo OK
