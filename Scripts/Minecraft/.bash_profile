#!/bin/bash
cat << '__EOF__' >> ~/.bash_profile
# .bash_profile
. "/opt/MC_Manage/mc_env.bash"
__EOF__

cp ~/.bash_profile "/opt/MC_Manage/"

