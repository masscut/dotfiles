#/bin/sh
PWD=`pwd`

# Delete existing dotfiles
rm -f ~/.vimrc
rm -f ~/.gvimrc
rm -rf ~/.vim
rm -f ~/.tmux.conf
rm -rf ~/.tmux

# Create symlink
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/gvimrc ~/.gvimrc
ln -sf $PWD/vim ~/.vim
ln -sf $PWD/tmux.conf ~/.tmux.conf
ln -sfs $PWD/tmux ~/.tmux
ln -sf $PWD/peco  ~/.config/pecs
