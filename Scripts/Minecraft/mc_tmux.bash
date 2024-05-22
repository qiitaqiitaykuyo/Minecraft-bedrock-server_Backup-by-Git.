#!/bin/bash
cat << '__EOF__' > "/opt/MC_Manage/mc_tmux.bash"
#!/bin/bash
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

# tmux エイリアス
function mc_send () {
  /usr/bin/tmux send -t minecraft "$1" ENTER
}
__EOF__

