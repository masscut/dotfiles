# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.nvm/nvmsh" ]] && . ~/.nvm/nvm.sh

mkdir -p $HOME/tmp
agent="$HOME/tmp/.ssh-agent-`hostname`"
if [ -S "$agent" ]; then
  export SSH_AUTH_SOCK=$agent
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK=$agent
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
  ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
fi
if [ $TERM != "screen-bce" ]; then
  screen -S main -xRR
fi
