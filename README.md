README!  
**Required**  Ubuntu 22.04|24.04  &  bash  
ダウンロード  
```  
git clone --depth 1 "https://github.com/qiitaqiitaykuyo/Minecraft-bedrock-server_Backup-by-Git..git" ~/minecraft.git  
```  
  
インストール  
```  
cd ~/minecraft.git
sudo bash install.sh
```  
  
アップデート
```
cd ~/minecraft.git
bash update.sh
```  
  
Minecraft Server の起動＆接続＆終了  
```  
# usepriv='setpriv --reuid="$runas" --regid="$runas" --init-groups env XDG_RUNTIME_DIR=/run/user/$(id -u "$runas")'; 
# runas=minecraft eval "sudo $usepriv systemctl --user --no-pager" &>/dev/null
# [[ $? == 0 ]] && sudo loginctl enable-linger minecraft
sudo systemctl start minecraft
MC tmux a      # 切断：[Ctrl B] → [D]
sudo systemctl stop minecraft
```  
  
アンインストール  
```  
sudo systemctl stop minecraft; sudo systemctl disable minecraft
sudo rm "/etc/systemd/system/minecraft.service"
sudo loginctl disable-linger minecraft
sudo shutdown -r now  
  
Del_USER=minecraft ;Del_GROUP=minecraft
sudo deluser --system --remove-all-file --backup-to ~/ "$Del_USER"
# sudo delgroup --system --only-if-empty "$Del_GROUP"
# sudo rm -rf /opt/MC_Manage /opt/minecraft
# rm -rf ~/minecraft.tar.gz
```  

