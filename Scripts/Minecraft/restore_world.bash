cat << '__EOF__' > "/opt/MC_Manage/restore_world.bash"
#!/bin/bash
if [ ! -v MC_EnvCheck_INIT ] && [ -f "/opt/MC_Manage/mc_env.bash" ]; then
  . "/opt/MC_Manage/mc_env.bash"
fi

# 既存のワールドを上書き
function restore_world () {
  if [ ! -d "$Worlds_DIR/$2" ]; then
    echo "ワールドが存在しません。正しいフォルダ名を入力してください。"
    return 1
  fi

  unset Commit_ID
  if [ "$1" = "HEAD" ] || [ "$1" = "@" ] || [ "$1" = "" ]; then
    read Commit_ID < \
    <(git --git-dir="$Worlds_Bak_DIR/.git" \
          --work-tree="$Worlds_DIR" \
          for-each-ref \
            --sort=-committerdate \
            --count=1 \
            --format="%(objectname:short)" \
            refs/heads)
  fi
  Commit_ID=${Commit_ID:-$1}
  backup_worlds 'Backup before restore'
  git --git-dir="$Worlds_Bak_DIR/.git" \
      --work-tree="$Worlds_DIR" \
      restore --no-overlay --worktree --source=$Commit_ID -- "$2"
}

# 別のワールドとして復元
function restore_another () {
  if [ "$3" = "" ]; then
    echo "復元先のフォルダ名が入力されていません。新しいフォルダ名を入力してください。"
    return 1
  fi

  Another_Name="$3"
  Another_DIR="$Worlds_DIR/$Another_Name"
  if [ -d "$Another_DIR" ]; then
    echo "すでにその名前のフォルダーが存在しています。別の名前で再度実行してください。"
    return 1
  fi
  mkdir -p "$Another_DIR"
  git -C "$Worlds_Bak_DIR" archive --format=tar $1 -- "$2" | tar Cx "$Another_DIR" --strip-components 1
}

__EOF__

