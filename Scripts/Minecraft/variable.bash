#!/bin/bash
cat << '__EOF__' > "/opt/MC_Manage/variable.bash"
#!/bin/bash
export Mine_DIR Worlds_DIR Script_Path Props_Bak_DIR Worlds_Bak_DIR

# 変数
      Mine_DIR="/opt/minecraft"
    Worlds_DIR="/opt/minecraft/worlds"
   Script_Path="/opt/MC_Manage"
 Props_Bak_DIR="/opt/MC_Manage/Properties"
Worlds_Bak_DIR="/opt/MC_Manage/World_Backup"

__EOF__

