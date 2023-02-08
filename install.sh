#!/bin/bash
#Install script for .zshrc file
#copy .zshrc from repository to current user dir
#

set -e

echo "+++++++++++++++++++++++++++++++++++++++++++++++++"

function install_powerlevel10k(){
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

if [ -d ~/.oh-my-zsh ];
then
    echo "oh-my-zsh installed"
    if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ];
    then
        echo "Powerlevel10k installed"
    else
        echo "installing Powerlevel10k..."
        install_powerlevel10k 
        echo "Powerlevel10k installed."
        echo "All jobs done. Jolly good!"
        echo "restart terminal/ssh connection"
    fi
else
    echo "oh-my-zsh is missingi!"
    echo "installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "oh-my-zsh installed."
    echo "installing Powerlevel10k..."
    install_powerlevel10k
    echo "Powerlevel10k installed."
    echo "All jobs done. Jolly good!"
fi

cp .zshrc ~/ && echo ".zshrc from git repo copied to home dir"

echo "Set ZSH_THEME=\"powerlevel10k/powerlevel10k\" in ~/.zshrc."
echo "end run 'source ~/.zshrc'"

exit 0
