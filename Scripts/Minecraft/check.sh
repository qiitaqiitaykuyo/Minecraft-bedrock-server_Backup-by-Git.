DIR=/opt/MC_Manage ;A=0 ;if : ;then
  [ -e $DIR/start.sh ] || eval 'A=1 ;echo "not exist \"start.sh\". Please create it."'
  [ -e $DIR/backup.sh ] || eval 'A=1 ;echo "not exist \"backup.sh\". Please create it."'
  [ -e $DIR/stop.sh ] || eval 'A=1 ;echo "not exist \"stop.sh\". Please create it."'
  [ -e $DIR/mc_env.bash ] || eval 'A=1 ;echo "not exist \"mc_env.bash\". Please create it."'
  [ -e $DIR/variable.bash ] || eval 'A=1 ;echo "not exist \"variable.bash\". Please create it."'
  [ -e $DIR/mc_tmux.bash ] || eval 'A=1 ;echo "not exist \"mc_tmux.bash\". Please create it."'
  [ -e $DIR/backup_props.bash ] || eval 'A=1 ;echo "not exist \"backup_props.bash\". Please create it."'
  [ -e $DIR/backup_worlds.bash ] || eval 'A=1 ;echo "not exist \"backup_worlds.bash\". Please create it."'
  [ -e $DIR/nonstop_save.bash ] || eval 'A=1 ;echo "not exist \"nonstop_save.bash\". Please create it."'
  [ -e $DIR/restore_world.bash ] || eval 'A=1 ;echo "not exist \"restore_world.bash\". Please create it."'
  [ -e $DIR/git_delete.bash ] || eval 'A=1 ;echo "not exist \"git_delete.bash\". Please create it."'
  [ "$A" = "0" ] && echo "OK. All files exist."
fi
