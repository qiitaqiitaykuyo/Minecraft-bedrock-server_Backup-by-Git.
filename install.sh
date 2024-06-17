#!/bin/bash
### execution: USER;  privilege: sudo ###

baseDIR="$(dirname -- $(realpath -- "${BASH_SOURCE[0]:-$0}"))"; echo "$baseDIR"

if (id minecraft) ;then exit 1 ;fi
if [ -d /opt/MC_Manage ] ;then exit 2 ;fi
if [ -d /opt/minecraft ] ;then exit 3 ;fi

if [[ ! -f "$baseDIR/update.sh" ]]; then 
  cp "$baseDIR/Scripts/Update/update_1.sh" "$baseDIR/update.sh" 
fi

sudo apt install tar unzip curl wget tmux git -y

New_USER=minecraft
HOME_DIR=/opt/minecraft
New_GROUP=$New_USER
Login_Shell=/bin/bash

sudo adduser --system \
             --home $HOME_DIR \
             --shell $Login_Shell \
             --group \
             $New_USER

sudo -i -u "$New_USER" systemctl start dbus --user
usepriv='setpriv --reuid="$runas" --regid="$runas" --init-groups env XDG_RUNTIME_DIR=/run/user/$(id -u "$runas")';
runas="$New_USER" eval "sudo $usepriv systemctl --user --no-pager" &>/dev/null

sudo mkdir -p "/opt/MC_Manage/"{"Properties","World_Backup"}
sudo chown -R $New_USER:$New_GROUP "/opt/MC_Manage/"
sudo chmod -R 750 "/opt/MC_Manage/"

sudo chmod -R +x "$baseDIR/Scripts/"*

bash "$baseDIR/Scripts/USER/minecraft.service"
bash "$baseDIR/Scripts/USER/start.sh"
bash "$baseDIR/Scripts/USER/backup.sh"
bash "$baseDIR/Scripts/USER/stop.sh"

sudo chown $New_USER:$New_GROUP "/opt/MC_Manage/start.sh" "/opt/MC_Manage/backup.sh" "/opt/MC_Manage/stop.sh"
sudo chmod 751 "/opt/MC_Manage/start.sh" "/opt/MC_Manage/backup.sh" "/opt/MC_Manage/stop.sh"

bash "$baseDIR/Scripts/USER/.bash_aliases"
bash "$baseDIR/Scripts/USER/.bashrc"

sudo \cp -vfRT "$baseDIR/Scripts/Minecraft/" "/opt/MC_Manage/Scripts/"
sudo bash -c 'for file in `find "/opt/MC_Manage/Scripts/" -maxdepth 1 -type f` ;do sed -i -e "s/\r//g" "$file" && echo $[++i].OK ;done'
sudo chown -R $New_USER:$New_GROUP "/opt/MC_Manage/Scripts/"


### execution: minecraft;  privilege: minecraft ###

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
sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/check.sh"

sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/download.sh"

sudo systemctl daemon-reload

sudo loginctl enable-linger $New_USER


exit 0
