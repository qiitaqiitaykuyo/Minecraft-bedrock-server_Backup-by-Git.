cat << '__EOF__' >> ~/.bash_aliases
function MC () {
  unset Arguments
  Arguments="${*//\"/\\\"}"
  Arguments="${Arguments:-exec bash --login}"
  sudo setpriv --reuid=$(/usr/bin/id -u minecraft) --regid=$(/usr/bin/id -g minecraft) --init-groups --reset-env bash --login -O expand_aliases -c "cd ~;IFS=' ' ${Arguments//\\\"/\"}"
}
__EOF__

