#!/bin/bash
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
download="/opt/MC_Manage/Scripts/download.sh"

echo -n $'\n'
echo "In the process of Update 3"
echo "directory: /opt/minecraft"

sudo -i -u minecraft bash "$download"

echo Updated.

# "update_2.sh" の最後のコマンドが `bash "$updateDIR/update_3.sh"`
# であるため、このファイルの終了コードが "update.sh" の `ExitCODE="$?"`
# に渡される。ただし、`find -exec bash -- {} +` で "update_2.sh" を
# 実行しているため、find によって 0 以外のすべての終了コードは 1 に変換される
exit 0
