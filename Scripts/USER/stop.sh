#!/bin/bash
sudo su -c "cat << '__EOF__' > \"/opt/MC_Manage/stop.sh\"
"'#!/bin/bash''
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

# Minecraft Server save & terminate
if [ "`type -t mc_save`" != "function" ]; then
  . "$Script_Path/nonstop_save.bash"
fi
mc_save commit unnecessary

/usr/bin/tmux send -t minecraft stop ENTER
/bin/sleep 20
/usr/bin/tmux kill-session -t minecraft

if [ "`type -t backup_worlds`" != "function" ]; then
  . "$Script_Path/backup_worlds.bash"
fi
backup_worlds "Backup of stopped servers"

echo "Stopped Minecraft Server"
__EOF__'

