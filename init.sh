#/bin/sh
PWD=`pwd`

# Delete existing dotfiles
rm -f ~/.vimrc
rm -f ~/.gvimrc
rm -rf ~/.vim
rm -f ~/.bashrc
rm -f ~/.zshrc

# Create symlink
ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.gvimrc ~/.gvimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.berkshelf ~/.berkshelf

# Install neobundle.vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
