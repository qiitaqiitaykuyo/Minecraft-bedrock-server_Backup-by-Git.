#!/bin/bash
sudo su -c "cat << '__EOF__' > \"/opt/MC_Manage/start.sh\"
"'#!/bin/bash''
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

# Minecraft Server start
/usr/bin/tmux new-session -s minecraft -d
/usr/bin/tmux pipe-pane -t minecraft "cat >$Mine_DIR/Command.log"
/usr/bin/tmux send -t minecraft "LD_LIBRARY_PATH=$Mine_DIR ./bedrock_server | tee $Mine_DIR/Result.log" ENTER
/usr/bin/tmux send -t minecraft "gamerule showcoordinates true" ENTER
/usr/bin/tmux send -t minecraft "gamerule keepInventory true" ENTER
__EOF__'

