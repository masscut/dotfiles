#/bin/sh
PWD=`pwd`

# Delete existing dotfiles
rm -f ~/.vimrc
rm -f ~/.gvimrc
rm -rf ~/.vim
rm -f ~/.zshrc

# Create symlink
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/gvimrc ~/.gvimrc
ln -s $PWD/vim ~/.vim
ln -s $PWD/zshrc ~/.zshrc
