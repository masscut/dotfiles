#/bin/sh
PWD=`pwd`

git submodule init
git submodule update

ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.gvimrc ~/.gvimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.screenrc ~/.screenrc
ln -s $PWD/.bashrc ~/.bashrc

vi +NeoBundleInstall +q
