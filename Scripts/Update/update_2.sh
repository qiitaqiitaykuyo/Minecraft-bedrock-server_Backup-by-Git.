#!/bin/bash
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
download="/opt/MC_Manage/Scripts/download.sh"

echo -n $'\n'
echo "/opt/minecraft"

sudo -i -u minecraft bash "$download"

echo Updated.
