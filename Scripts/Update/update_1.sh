#!/bin/bash -u
set -o nounset

scriptDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
updateDIR="$scriptDIR/Scripts/Update"
baseDIR="${updateDIR%/Scripts/Update}"
dirNAME="$(basename "$baseDIR")"

echo -n $'\n'
echo "In the process of Update 1"
echo "directory: $baseDIR"

if [[ -v baseDIR ]]; then
  find "$baseDIR" -xdev -depth ! -name "update.sh" -and ! -name "$dirNAME" -exec rm -df {} +
fi

git clone --depth 1 "https://github.com/qiitaqiitaykuyo/Minecraft-bedrock-server_Backup-by-Git..git" "$baseDIR/.minecraft.git"

\cp -fRT "$baseDIR/.minecraft.git" "$baseDIR"

# `-exec {} +` はファイルをまとめて実行する；グループ実行
# 複数 update_2.sh があっても実行されるのは最初に見つかったものだけになる
#（２番目以降のものは、最初に見つかったものの引数になる）
#（`-exec {} \;` はファイルを１つずつ実行する；単体実行）
find "$updateDIR" -type f -name "update_2.sh" -exec bash -- {} +
ExitCODE="$?"

[[ "${BASH_SOURCE[0]}" = "${0}" ]] && EscCMD="exit" || EscCMD="return"
alias 'goto'="$EscCMD "
alias ':eof'="$ExitCODE"
shopt -s expand_aliases

# 最後の ; を忘れないように
{ \cp -vf "$updateDIR/update_1.sh" "$baseDIR/update.sh" && goto :eof || goto :eof; }
