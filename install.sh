#!/bin/bash

if (id minecraft) ;then exit 1 ;fi
if [ -d /opt/MC_Manage ] ;then exit 2 ;fi

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


sudo -i -u minecraft bash "./Scripts/Minecraft/Properties"
sudo -i -u minecraft bash "./Scripts/Minecraft/World_Backup"
sudo -i -u minecraft bash "./Scripts/Minecraft/.bash_profile"
sudo -i -u minecraft bash "./Scripts/Minecraft/mc_env.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/variable.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/mc_tmux.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/nonstop_save.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/backup_props.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/backup_worlds.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/restore_world.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/git_delete.bash"
sudo -i -u minecraft bash "./Scripts/Minecraft/check.sh"


sudo bash -c 'for file in /opt/MC_Manage/* ;do sed -i -e "s/\r//g" "$file" ;done'

sudo systemctl daemon-reload


