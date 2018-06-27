# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Set bindkey
bindkey -v

# user bin
if [ -d $HOME/bin ]; then
    export PATH=$PATH:$HOME/bin
fi

case ${OSTYPE} in
    darwin*) # for Mac
        # vim setteing
        if [ -d /Applications/MacVim.app ]; then
            PATH="$PATH:/Applications/MacVim.app/Contents/bin"
	        alias vim="mvim --remote-tab-silent"
	        alias vi="vim"
	        alias vimdiff="mvimdiff"
	        alias view="mview"
        fi
        # rbenv
        if [ -f /usr/local/bin/rbenv ]; then
            eval "$(rbenv init - zsh)"
        fi
        # awscli
        if [ -f /usr/local/share/zsh/site-functions/_aws ]; then
            source /usr/local/share/zsh/site-functions/_aws
        fi
        # JAVA
        #export JAVA_HOME=`/usr/libexec/java_home`
        ;;
    linux*) # for linux
        # rbenv
        if [ -d $HOME/.rbenv ]; then
            export PATH=$PATH:$HOME/.rbenv/bin
            eval "$(rbenv init - zsh)"
        fi
        # awscli 
        if [ -f /usr/local/bin/aws_zsh_completer.sh ]; then
            source /usr/local/bin/aws_zsh_completer.sh
        fi
        # enable color support of ls and also add handy aliases
        if [ -x /usr/bin/dircolors ]; then
            test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
            alias ls='ls --color=auto'
            #alias dir='dir --color=auto'
            #alias vdir='vdir --color=auto'

            alias grep='grep --color=auto'
            alias fgrep='fgrep --color=auto'
            alias egrep='egrep --color=auto'
        fi
        ;;
    *) #for Unknown
        ;;
esac

# history
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:ignoredups

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# less
if [ -f /usr/local/bin/src-hilite-lesspipe.sh ]; then
    export LESS='--no-init -R'
    export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
fi

# Added by the Heroku Toolbelt
if [ -d /usr/local/heroku ]; then
    export PATH="/usr/local/heroku/bin:$PATH"
fi

# virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper_lazy.sh ]; then
    source /usr/local/bin/virtualenvwrapper_lazy.sh
fi

# sdkman
if [ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    setopt clobber
    export SDKMAN_DIR="$HOME/.sdkman"
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    setopt noclobber
fi

# nodebrew
if [ -d $HOME/.nodebrew ]; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# tmux start up
#if [ $SHLVL = 1 ]; then
#    alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux/session"
#fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/bin/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/bin/google-cloud-sdk/completion.zsh.inc"; fi

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi
