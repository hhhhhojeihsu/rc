#!/bin/sh

set -e #stop on error

ans=""

#test if .tmux.conf exsists
if [ -e "~/.tmux.conf" ]; then
    echo ".tmux.conf already exsists. Do you want to replace it?"
    read -p "(y/n): " ans
    if [ ${ans} = "y" ]; then
        echo "rename old .tmux.conf to .tmux.conf_old?"
        read -p "(y/n): " ans
        if [ ${ans} = "y" ]; then
            mv ~/.tmux.conf ~/.tmux.conf_old
        else
            rm ~/.tmux.conf
        fi
        cp ./.tmux.conf ~/.tmux.conf
    elif [ ${ans} = "n" ]; then
        echo "ignored."
    else
        echo "wrong input, ignored."
    fi
fi


#test if .bash_profile exsists
if [ -e "~/.bash_profile" ]; then
    echo ".bash_profile already exsists. Do you want to replace it?"
    read -p "(y/n): " ans
    if [ ${ans} = "y" ]; then
        echo "rename old .bash_profile to .bash_profile_old?"
        read -p "(y/n): " ans
        if [ ${ans} = "y" ]; then
            mv ~/.bash_profile ~/.bash_profile_old
        else
            rm ~/.bash_profile
        fi
        cp ./.bash_profile ~/.bash_profile
    elif [ ${ans} = "n" ]; then
        echo "ignored."
    else
        echo "wrong input, ignored."
    fi
fi

#test if .vimrc exsists
if [ -e "~/.vimrc" ]; then
    echo ".vimrc already exsists. Do you want to replace it?"
    read -p "(y/n): " ans
    if [ ${ans} = "y" ]; then
        echo "rename old .vimrc to .vimrc_old?"
        read -p "(y/n): " ans
        if [ ${ans} = "y" ]; then
            mv ~/.vimrc ~/.vimrc_old
        else
            rm ~/.vimrc
        fi
        cp ./.vimrc ~/.vimrc
    elif [ ${ans} = "n" ]; then
        echo "ignored."
    else
        echo "wrong input, ignored."
    fi
fi

#test if Vundle installed
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

#install vim plugins
vim +PluginInstall +qall

