# Installs enviornment from scratch

# Initialize submodules (e.g. dotbot)
git submodule update --init --recursive

# Link dotfiles
./install_dotbot.sh

# Install zsh plugins
/bin/zsh ~/.zshrc

# Change default shell to zsh
echo "Change default shell to zsh"
chsh -s /bin/zsh


