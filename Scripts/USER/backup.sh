#!/bin/bash
sudo su -c "cat << '__EOF__' > \"/opt/MC_Manage/backup.sh\"
"'#!/bin/bash''
BK_INTERVAL=2h

/usr/bin/setpriv \
  --reuid=$(/usr/bin/id -u minecraft) \
  --regid=$(/usr/bin/id -g minecraft) \
  --init-groups \
/usr/bin/env XDG_RUNTIME_DIR=/run/user/$(/usr/bin/id -u minecraft) \
  /usr/bin/systemd-run \
    --on-active=${BK_INTERVAL} \
    --on-unit-active=${BK_INTERVAL} \
    --user \
    --collect \
    --unit=nonstop_save.service \
      /bin/bash -c "\
        . /opt/MC_Manage/nonstop_save.bash ;\
        HOME=/opt/minecraft mc_save BAK_SERVICE"
__EOF__'

