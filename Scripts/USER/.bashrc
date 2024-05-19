. ~/.bashrc; if [ "`declare -F MC`" != "MC" ]; then
  echo "describe .bash_aliases"
  cat << '__EOF__' >> ~/.bashrc
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
__EOF__
fi

