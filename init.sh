#/bin/sh
PWD=`pwd`

# Centos
redhat=/etc/redhat-release
if [ -e $redhat ]; then
  sudo yum -y install vim-enhanced
fi

git submodule init
git submodule update

ln -s $PWD/.vimrc ~/.vimrc
ln -s $PWD/.vim ~/.vim
ln -s $PWD/.screenrc ~/.screenrc
