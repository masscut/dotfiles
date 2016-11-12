#/bin/sh
PWD=`pwd`

# Delete existing dotfiles
rm -f ~/.vimrc
rm -f ~/.gvimrc
rm -rf ~/.vim
rm -f ~/.zshrc
rm -f ~/.zpreztorc
rm -f ~/.zprofile
rm -f ~/.tmux.conf
rm -rf ~/.tmux

# Create symlink
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/gvimrc ~/.gvimrc
ln -s $PWD/vim ~/.vim
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/zpreztorc ~/.zpreztorc
ln -s $PWD/zprofile ~/.zprofile
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/tmux ~/.tmux
