#!/bin/bash -e

sudo sed -i "s|%sudo\tALL=(ALL:ALL) ALL|%sudo\tALL=(ALL:ALL) NOPASSWD:ALL|g" /etc/sudoers

# Install basic tools
sudo apt install -y build-essential git vim curl wget

# Install asdf
# git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
# source "$HOME/.asdf/asdf.sh"

# Install asdf plugins
# asdf plugin add nodejs
# asdf install nodejs latest

echo 'source "$HOME/.bash_user_profile"' >> ~/.bashrc

# Link config files
ln -sf "$HOME/dotfiles/.bash_user_profile" "$HOME/.bash_user_profile"
ln -sf "$HOME/dotfiles/.asdfrc" "$HOME/.asdfrc"
ln -sf "$HOME/dotfiles/.gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/dotfiles/.vimrc" "$HOME/.vimrc"

echo '. "$HOME/.bash_user_profile"' >> ~/.bashrc

# Install utils
sudo apt install -y gh wslu
