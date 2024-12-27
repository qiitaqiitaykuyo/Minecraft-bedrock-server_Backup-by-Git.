#!/bin/bash
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
download="/opt/MC_Manage/Scripts/download.sh"

echo -n $'\n'
echo "In the process of Update 3"
echo "directory: /opt/minecraft"

sudo -i -u minecraft bash "$download"

echo Updated.; exit 3245
