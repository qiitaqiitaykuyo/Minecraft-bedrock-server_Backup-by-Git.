#!/bin/bash

sudo apt install ufw bind9-dnsutils -y

bash "./Scripts/Firewall/Minecraft"

bash "./Scripts/Firewall/AcceptMC.bash"


