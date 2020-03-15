#!/bin/bash

 echo "Remove zplug and zsh"
 rm -rf ~/.zplug ~/.zshrc

 echo "Remove neovim"
 rm -rf ~/.config/nvim/init.vim ~/.local/share/nvim ~/.local/bin/nvim

 echo "Remove abduco"
 rm -rf ~/.local/bin/abduco

 echo "Remove nvr"
 rm -rf ~/.local/bin/nvr

 echo "Rerunning install script to see if all programs are installed"
 sleep 1
 ./install.sh

function check_dep() {
	command -v $1 >/dev/null 2>&1 || { echo >&2 "Test Failed! $1 not found. $2"; exit 1; }
}


check_dep zsh
check_dep abduco
check_dep nvim
check_dep nvr
