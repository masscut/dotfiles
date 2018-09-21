# user bin
if [ -d $HOME/bin ]; 
    set PATH $PATH $HOME/bin
end

switch (uname)
case Darwin # for Mac
    # vim setting
    if [ -d /Applications/MacVim.app ]
        set PATH $PATH /Applications/MacVim.app/Contents/bin
        function vim
            mvim --remote-tab-silent $argv
        end
        
        function vi
            vim $argv
        end

        function vimdiff
            mvimdiff $argv
        end

        function view
            mview $argv
        end
    end
case Linux # for linux
#    # enable color support of ls and also add handy aliases
#    if [ -x /usr/bin/dircolors ]; then
#        test -r ~/.dircolors; and eval (dircolors -b ~/.dircolors); or eval (dircolors -b)
#        alias ls='ls --color=auto'
#
#        alias grep='grep --color=auto'
#        alias fgrep='fgrep --color=auto'
#        alias egrep='egrep --color=auto'
#    end
case '*' #for Unknown
end

# some more ls aliases
function ll 
    ls -alF $argv
end

function la
    ls -aF $argv
end

function l
    ls -CF $argv
end

# less
if [ -f /usr/local/bin/src-hilite-lesspipe.sh ];
    set -x LESS '--no-init --quit-if-one-screen -R'
    set -x LESSOPEN '| /usr/local/bin/src-hilite-lesspipe.sh %s'
end

# awscli
if [ -x /usr/local/bin/aws_completer ];
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end

# tmux start up
#if [ $SHLVL = 1 ]; then
#    alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux/session"
#fi

# The next line updates PATH for the Google Cloud SDK.
#if [ -f "$HOME/bin/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/bin/google-cloud-sdk/path.zsh.inc"; end

# The next line enables shell command completion for gcloud.
#if [ -f "$HOME/bin/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/bin/google-cloud-sdk/completion.zsh.inc"; end

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
