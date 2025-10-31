#!/bin/bash -e

##################
# Basic packages #
##################

sudo apt update
sudo apt upgrade -y

sudo apt install -y \
	build-essential curl wget git \
	vim gh tmux \
	g++-12 gcc-12 make \
	python3 python3-pip python3-venv \
	npm nodejs \
	pandoc texlive-full \
	zsh starship \

##########
# Nodenv #
##########

git clone https://github.com/nodenv/nodenv ~/.nodenv --depth 1
git clone https://github.com/nodenv/node-build ~/.nodenv/plugins/node-build --depth 1

######
# uv #
######

curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh

##########
# Docker #
##########

# Uninstall old versions
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove -y $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the Docker packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# run Docker without sudo
sudo gpasswd -a $USER docker

# Start service
sudo systemctl enable docker.service

#################
# Coding Agents #
#################

npm install -g @openai/codex
npm install -g @anthropic-ai/claude-code

##############
# Link files #
##############

ln -s $HOME/dotfiles/config/.npmrc $HOME/
ln -s $HOME/dotfiles/config/.vimrc $HOME/

ln -s $HOME/dotfiles/config/.zprofile $HOME/
ln -s $HOME/dotfiles/config/.zshenv $HOME/
ln -s $HOME/dotfiles/config/.zshrc $HOME/
