#/bin/sh
PWD=`pwd`

# Delete existing dotfiles
# rm -f ~/.vimrc
# rm -f ~/.gvimrc
# rm -rf ~/.vim

# install fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Create symlink
# ln -sf $PWD/vimrc ~/.vimrc
# ln -sf $PWD/vim ~/.vim
ln -sf $PWD/fish/config.fish  ~/.config/fish/config.fish
ln -sf $PWD/fish/fishfile  ~/.config/fish/fishfile
ln -sf $PWD/fish/fish_variables  ~/.config/fish/fish_variables
ln -sf $PWD/fish/conf.d/peco.fish  ~/.config/fish/conf.d/peco.fish
ln -sf $PWD/peco  ~/.config/peco

