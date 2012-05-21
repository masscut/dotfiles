# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

alias grep='grep --color=auto'
alias fgrep='grep --color=auto'
alias egrep='grep --color=auto'

# RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# nvm
[[ -s "$HOME/.nvm/nvm.sh" ]] && source "$HOME/.nvm/nvm.sh"

mkdir -p $HOME/tmp
agent="$HOME/tmp/.ssh-agent-`hostname`"
if [ -S "$agent" ]; then
  export SSH_AUTH_SOCK=$agent
elif [ ! -S "$SSH_AUTH_SOCK" ]; then
  export SSH_AUTH_SOCK=$agent
elif [ ! -L "$SSH_AUTH_SOCK" ]; then
  ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
fi

[ $STY ] || screen -rx || screen -S main -D -RR

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
