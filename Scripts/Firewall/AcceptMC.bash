cat << '__EOF__' > ~/AcceptMC.bash
#!/bin/bash
# 詳細を入力
printf ' Minecraft に参加する人の名前: ' ; read MC_Connect_USER ; echo $MC_Connect_USER
printf ' Minecraft に参加する人のIPまたはホスト名: ' ; read HOSTNAME_OR_IP ; echo $HOSTNAME_OR_IP

# 変数解除
unset IP_Addr MC_USER

# 古いファイアウォールの構成
MC_USER="${MC_Connect_USER:-NONE_OLD_FW}"
Old_FW=$(sudo ufw show added | awk "/Minecraft comment/"' && '"/$MC_USER/")
Old_FW="${Old_FW#'ufw '}"

# 新しいファイアウォールの構成
IP_Addr="$(dig +short $HOSTNAME_OR_IP)"
IP_Addr="${IP_Addr:-$HOSTNAME_OR_IP}"
New_FW="allow from $IP_Addr to any app Minecraft comment '$MC_USER'"

# 設定を更新
if [ "$Old_FW" != "$New_FW" ]; then
  [ -n "$Old_FW" ] && eval sudo ufw delete "$Old_FW" && echo "DELETE Older FireWall"
  eval sudo ufw "$New_FW" && echo "CREATE New FireWall"
else
  echo "do not update."
fi

# 確認
sudo ufw status | awk '/Action/;/------/;/Minecraft/'

echo "Script Finish"
exit 0
__EOF__

