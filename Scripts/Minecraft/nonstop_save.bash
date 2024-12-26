#!/bin/bash
cat << '__EOF__' > "/opt/MC_Manage/nonstop_save.bash"
#!/bin/bash
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

# Save Section
function mc_save () {
  if [ "$(tmux ls -F '#{session_name}' -f '#{==:#{session_name},minecraft}' 2>/dev/null)" != "minecraft" ]; then
    if [ "${1}" = "BAK_SERVICE" ]; then
      XDG_RUNTIME_DIR=/run/user/$(id -u minecraft) systemctl --user stop nonstop_save.timer
      exit 0
    fi || true
    git --git-dir="$Worlds_Bak_DIR/.git" \
        --work-tree="$Worlds_DIR" \
        add --intent-to-add -- :/
    git --git-dir="$Worlds_Bak_DIR/.git" \
        --work-tree="$Worlds_DIR" \
        diff --quiet --exit-code
    [ "$?" = "1" ] && backup_worlds 'Backup of stopped servers'
    # 新規ファイルか更新されたファイルがあった場合は、$?=1 を示す
    return 0
  fi

  /usr/bin/tmux send -t minecraft "save resume" ENTER
  sleep 1

  /usr/bin/tmux send -t minecraft "save hold" ENTER
  sleep 1

  EXITCODE=1 ; TRY_COUNT=0
  while [ "$EXITCODE" -ne "0" ]; do
   ((TRY_COUNT++))
    /usr/bin/tmux send -t minecraft "save query" ENTER
    sleep 5
    grep "Data saved. Files are now ready to be copied." <(tail -30 "$Mine_DIR/Result.log") > /dev/null 2>&1
    EXITCODE=$?
    if [ "$TRY_COUNT" -eq "120" ]; then break; fi
  done

  if [ "${1}_${2}" != "commit_unnecessary" ]; then
    backup_worlds 'Save running server'
  fi

  /usr/bin/tmux send -t minecraft "save resume" ENTER
}

__EOF__

