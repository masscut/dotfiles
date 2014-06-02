#/bin/sh
PWD=`pwd`

rm -f ~/.vimrc
rm -f ~/.gvimrc
rm -rf ~/.vim
rm -f ~/.bashrc
rm -f ~/.zshrc

ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.gvimrc ~/.gvimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.bashrc ~/.bashrc
ln -s $PWD/.zshrc ~/.zshrc
ln -s $PWD/.berkshelf ~/.berkshelf

#vi +NeoBundleInstall +q
