#!/bin/bash -e

sudo sed -i "s|%sudo\tALL=(ALL:ALL) ALL|%sudo\tALL=(ALL:ALL) NOPASSWD:ALL|g" /etc/sudoers

# Install homebrew
sudo apt insatll -y build-essential procps curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

# Install utils
brew install tmux eza bat

# Install neovim
brew install neovim fd ripgrep llvm

# Development tools
brew install node yarn deno rye rustup-init gdb gcc

# GitHub Authentication
sudo apt install -y gh wslu

for file in ".bashrc .gitconfig"; do
    if [ -e "$HOME/$file" ]; then
        rm "$HOME/$file"
    fi
    ln -s "$HOME/dotfiles/$file" "$HOME/$file"
done

for dir in $(ls "$HOME/dotfiles/config"); do
    if [ -e "$HOME/.config/$dir" ]; then
        rm -rf "$HOME/.config/$dir"
    fi
    ln -s "$HOME/dotfiles/config/$dir" "$HOME/.config/$file"
done

