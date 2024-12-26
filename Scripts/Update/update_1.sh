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

sudo \cp -TRf "$baseDIR/Scripts/Minecraft/" "/opt/MC_Manage/Scripts/"
sudo bash -c 'for file in `find "/opt/MC_Manage/Scripts/" -maxdepth 1 -type f` ;do sed -i -e "s/\r//g" "$file" ;done'
sudo chown -R minecraft:minecraft "/opt/MC_Manage/Scripts/"

### Create function file from bash script. ###
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/Properties"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/World_Backup"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/mc_env.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/.bash_profile"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/variable.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/mc_tmux.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/nonstop_save.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/backup_props.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/backup_worlds.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/restore_world.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/git_delete.bash"

find "$baseDIR" -type f -name "update_2.sh" -exec bash -- {} +

