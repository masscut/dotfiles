#/bin/sh
PWD=`pwd`

git clone https://github.com/Shougo/neobundle.vim ~/.vim/neobundle.vim.git

ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.screenrc ~/.screenrc
