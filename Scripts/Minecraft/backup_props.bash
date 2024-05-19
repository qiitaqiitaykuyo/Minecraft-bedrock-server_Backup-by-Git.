cat << '__EOF__' > "/opt/MC_Manage/backup_props.bash"
#!/bin/bash
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

# エイリアス 設定ファイル関連
function backup_props () {
  git --git-dir="$Props_Bak_DIR/.git" \
      --work-tree="$Mine_DIR" \
      add -- permissions.json server.properties allowlist.json
  git -C "$Props_Bak_DIR" commit --amend --date=now --allow-empty-message -m ''"$@"

  mc_delete "$Props_Bak_DIR" 10
}

function show_props_bak () {
  git -C "$Props_Bak_DIR" --no-pager log --max-count=${1:-5} --reflog --format='%C(auto)%+h [%ad] %Cgreen%s' --name-only; echo ''
}

__EOF__

