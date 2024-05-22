#!/bin/bash
cat << '__EOF__' > "/opt/MC_Manage/backup_worlds.bash"
#!/bin/bash
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

# エイリアス ワールドデータ関連
function backup_worlds () {
  SET_PATH="GIT_DIR=\"$Worlds_Bak_DIR/.git\" GIT_WORK_TREE=\"$Worlds_DIR\""
  unset Args
  while read READ; do 
    Args="$Args \"$READ\""
  done < <(eval $SET_PATH git ls-files --others --exclude-standard :/)
  eval $SET_PATH git add -- $Args >/dev/null 2>&1
  eval $SET_PATH git add --update
  eval $SET_PATH git update-index --remove --stdin < <(eval $SET_PATH git ls-files :/)
  git -C "$Worlds_Bak_DIR" commit --amend --date=now --allow-empty-message -m ''"$@"
  unset SET_PATH

  mc_delete "$Worlds_Bak_DIR"
  echo "Backups have been completed."
}

function show_worlds_bak () {
  SKIP=0
  while read LINE; do
    git -C "$Worlds_Bak_DIR" log --max-count=1 --skip=$SKIP --reflog --format='%C(auto)%h [%ad] %Cgreen%s'
    git -C "$Worlds_Bak_DIR" ls-tree -d --name-only $LINE
    echo ''
   ((SKIP++))
  done < <(git -C "$Worlds_Bak_DIR" log --max-count=${1:-5} --reflog --format='%C(auto)%h')
}

__EOF__

