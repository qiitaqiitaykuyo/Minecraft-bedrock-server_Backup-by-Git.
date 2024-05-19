cat << '__EOF__' > "/opt/MC_Manage/mc_env.bash"
#!/bin/bash
# profile evoker
set +u
export -n MC_EnvCheck_INIT ; unset MC_EnvCheck_INIT
declare MC_EnvCheck_INIT="MC_EnvCheck_INIT"
declare -x Script_Path="/opt/MC_Manage"

# Sourcing
if [ -f "$Script_Path/variable.bash" ]; then . "$Script_Path/variable.bash"; fi
if [ -f "$Script_Path/mc_tmux.bash" ]; then . "$Script_Path/mc_tmux.bash"; fi
if [ -f "$Script_Path/nonstop_save.bash" ]; then . "$Script_Path/nonstop_save.bash"; fi
if [ -f "$Script_Path/backup_props.bash" ]; then . "$Script_Path/backup_props.bash"; fi
if [ -f "$Script_Path/backup_worlds.bash" ]; then . "$Script_Path/backup_worlds.bash"; fi
if [ -f "$Script_Path/restore_world.bash" ]; then . "$Script_Path/restore_world.bash"; fi
if [ -f "$Script_Path/git_delete.bash" ]; then . "$Script_Path/git_delete.bash"; fi

# エイリアス
alias mc_start="echo start Minecraft Server; bash $Script_Path/start.sh"
alias mc_stop="echo terminate Minecraft Server; bash $Script_Path/stop.sh"
__EOF__

