#!/bin/bash -u
updateDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"
baseDIR="${updateDIR%/Scripts/Update}"
if [[ -z "${baseDIR:+'UNDEF -> Null'}" ]];then echo error; exit 1 ;fi

echo -n $'\n'
echo "In the process of Update 2"
echo "directory: /opt/MC_Manage"

### Script update. ###
sudo \cp -fRT "$baseDIR/Scripts/Minecraft/" "/opt/MC_Manage/Scripts/"
sudo bash -c 'for file in `find "/opt/MC_Manage/Scripts/" -maxdepth 1 -type f` ;do sed -i -e "s/\r//g" "$file"; echo "$file" ;done'
sudo chown -R minecraft:minecraft "/opt/MC_Manage/Scripts/"

### Create function file from bash script. ###
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/mc_env.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/variable.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/mc_tmux.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/nonstop_save.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/backup_props.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/backup_worlds.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/restore_world.bash"
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/git_delete.bash"

bash "$updateDIR/update_3.sh"
