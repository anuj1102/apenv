echo "Remove zplug and zsh"
rm -rf ~/.zplug ~/.zshrc

echo "Remove neovim"
rm -rf ~/.config/nvim/init.vim ~/.local/share/nvim ~/.local/bin/nvim

echo "Remove abduco"
rm -rf ~/.local/bin/abduco

echo "Rerunning install script to see if all programs are installed"
sleep 1
./install.sh
