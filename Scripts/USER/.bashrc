if [ "$(grep -E '\s*. ~/.bash_aliases'$ ~/.bashrc | sed '2,$d;s/^\s*//')" != ". ~/.bash_aliases" ]
then
  echo "describe .bash_aliases"
  cat << '__EOF__' >> ~/.bashrc
  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi
__EOF__
fi
