#!/bin/bash

CurrentDir=`pwd`

if (id minecraft) ;then exit 1 ;fi
if [ -d /opt/MC_Manage ] ;then exit 2 ;fi
if [ -d /opt/minecraft ] ;then exit 3 ;fi

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

sudo loginctl enable-linger $New_USER

sudo mkdir -p /opt/MC_Manage/{Properties,World_Backup}
sudo chown -R $New_USER:$New_GROUP "/opt/MC_Manage/"
sudo chmod -R 750 "/opt/MC_Manage/"


sudo chmod -R +x ./Scripts/*

bash "./Scripts/USER/minecraft.service"
bash "./Scripts/USER/start.sh"
bash "./Scripts/USER/backup.sh"
bash "./Scripts/USER/stop.sh"

sudo chown $New_USER:$New_GROUP "/opt/MC_Manage/start.sh" "/opt/MC_Manage/backup.sh" "/opt/MC_Manage/stop.sh"
sudo chmod 751 "/opt/MC_Manage/start.sh" "/opt/MC_Manage/backup.sh" "/opt/MC_Manage/stop.sh"


bash "./Scripts/USER/.bash_aliases"
bash "./Scripts/USER/.bashrc"


sudo cp -rf "$CurrentDir/Scripts/Minecraft" "/opt/MC_Manage/Scripts"
sudo chown -R $New_USER:$New_GROUP "/opt/MC_Manage/Scripts/"

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


sudo bash -c 'for file in `find /opt/MC_Manage/ -maxdepth 1 -type f` ;do sed -i -e "s/\r//g" "$file" && echo $[++i].OK ;done'

sudo systemctl daemon-reload


sudo -i -u minecraft bash "/opt/MC_Manage/Scripts/download.sh"


exit 0

