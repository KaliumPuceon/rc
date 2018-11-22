#! /bin/bash

# Home dir config files
ln -s ./bashrc ~/.bashrc
ln -s ./zshrc ~/.zshrc
ln -s ./tmux.conf ~/.tmux.conf
ln -s ./vimrc ~/.vimrc

# Setup vim dirs
mkdir ~/.vim
ln -s ~/.vimrc ~/.nvimrc
ln -s ~/.vim ~/.nvim

# ~/.config setup files
ln -s ./dotconfig/gitconfig ~/.config/gitconfig
ln -s ./dotconfig/i3 ~/.config/i3
ln -s ./dotconfig/i3status ~/.config/i3status
ln -s ./dotconfig/cmus ~/.config/cmus
ln -s ./dotconfig/mpv ~/.config/mpv
ln -s ./dotconfig/palettes ~/.config/palettes
ln -s ./dotconfig/nvim ~/.config/nvim
ln -s ./dotconfig/redshift.conf ~/.config/redshift.conf
ln -s ./dotconfig/vimb ~/.config/vimb

read -p 'Download vim plug? [y/N]: ' plug

if [ $plug == "y" || $plug == "Y" ]; then
    echo "grabbing vim-plug"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "run PlugInstall to complete setup"
fi

read -p 'Copy user scripts? [y/N]: ' scripts

if [ $scripts == "y" || $scripts == "Y" ]; then

    # Copy, don't link scripts, may need mods
    mkdir ~/.local/bin
    cp ./bin/* ~/.local/bin

fi
