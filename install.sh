#!/bin/bash
#Install script for .zshrc file
#copy .zshrc from repository to current user dir
#

set -e

function print_separator(){
    echo "============================================================================================"
}

function install_powerlevel10k(){
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

function install_oh_my_zsh(){
    (
        echo exit
    ) | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_zsh_autosuggestions(){
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

#Script begin

print_separator

if [ -d ~/.oh-my-zsh ];
then
    echo "oh-my-zsh installed"
    if [ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ];
    then
        echo "Powerlevel10k installed"
    else
        print_separator
        echo "installing Powerlevel10k..."
        install_powerlevel10k 
        echo "Powerlevel10k installed."
        echo "All jobs done. Jolly good!"
        echo "restart terminal/ssh connection"
    fi
    if [ -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ];
    then
        echo "zsh-autosuggestions plugin installed"
    else
        print_separator
        echo "installing zsh-autosuggestions plugin"
        install_zsh_autosuggestions
        echo "zsh-autosuggestion plugin installed."
    fi
else
    echo "oh-my-zsh is missingi!"
    echo "installing oh-my-zsh..."
    install_oh_my_zsh
    echo "oh-my-zsh installed."
    print_separator
    echo "installing Powerlevel10k..."
    install_powerlevel10k
    echo "Powerlevel10k installed."
    print_separator
    echo "All jobs done. Jolly good!"
fi


cp .p10k.zsh ~/ && echo ".p10k.zsh from git repo copied to home dir"

read -p "Copy .zshrc with preconfigured Powerlevel10k?: [Y|n]" ANSWER

if [ -z $ANSWER ] || [ $ANSWER = "Y" ];
then
    # echo "Copy .zshrc.with.p10k"
    cp .zshrc.with.p10k ~/.zshrc && echo ".zshrc copied from git repo to home dir  (with Powerlevel10k) "
else
    # echo "Copy .zshrc"
    cp .zshrc ~/ && echo ".zshrc copied from git repo to home dir"
    echo "Set ZSH_THEME=\"powerlevel10k/powerlevel10k\" in ~/.zshrc."
fi

print_separator

echo "run 'source ~/.zshrc'"

exit 0
