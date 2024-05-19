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
  
アンインストール  
```  
sudo loginctl disable-linger minecraft  
sudo shutdown -r now  
  
Del_USER=minecraft ;Del_GROUP=minecraft  
sudo deluser --system --remove-all-file --backup-to ~/ "$Del_USER"  
# sudo delgroup --system --only-if-empty "$Del_GROUP"  
# sudo rm -rf /opt/MC_Manage /opt/minecraft  
# rm -rf ~/minecraft.tar.gz  
```  

