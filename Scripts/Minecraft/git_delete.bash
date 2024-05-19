cat << '__EOF__' > "/opt/MC_Manage/git_delete.bash"
#!/bin/bash
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

function mc_delete () {
  unset SKIP Working_DIR
  SKIP=${2:-2}
  Working_DIR=${1:-$Worlds_Bak_DIR}

  while read COUNT_HEAD; do 
    git -C "$Working_DIR" reflog delete "HEAD@{$SKIP}"
  done < <(git -C "$Working_DIR" --no-pager log --walk-reflogs --skip=$SKIP --format='%gd' HEAD)

  while read COUNT_MAIN; do 
    git -C "$Working_DIR" reflog delete "$(git -C "$Working_DIR" branch --show-current)@{$SKIP}"
  done < <(git -C "$Working_DIR" --no-pager log --walk-reflogs --skip=$SKIP --format='%gd' refs/heads/$(git -C "$Working_DIR" branch --show-current))

  git -C "$Working_DIR" gc --quiet
}

__EOF__

