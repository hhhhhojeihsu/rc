#!/bin/sh

set -e #stop on error

ans=""

configs=".tmux.conf .bash_profile .vimrc .gitconfig"

for config in ${configs}; do
  #test if config exsists
  if [ -f "${HOME}/${config}" ]; then
    echo "${config} already exsists. Do you want to replace it?"
    read -p "(y/n): " ans
    if [ "${ans}" = "y" ]; then
      echo "rename old ${config} to ${config}_old?"
      read -p "(y/n): " ans
      if [ "${ans}" = "y" ]; then
        mv -v  "${HOME}/${config}" "${HOME}/${config}_old"
      fi
      cp -v "./${config}" ${HOME}/
    elif [ "${ans}" = "n" ]; then
      echo "${config} ignored."
    else
      echo "Wrong input, ignored."
    fi
  else
    cp -v "./${config}" ${HOME}/
  fi
done

# Append .bash_profile to .bashrc
cat ${HOME}/.bash_profile >> ${HOME}/.bashrc
rm ${HOME}/.bash_profile

#test if Vundle installed
if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
fi

#install vim plugins
vim +PluginInstall +qall

#test if tpm installed
if [ ! -d "${HOME}/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
  #install tmux plugins
  ${HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

#source .tmux.conf
tmux source ${HOME}/.tmux.conf

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
