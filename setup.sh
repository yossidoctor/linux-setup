#!/bin/bash

# Enable immediate exit on error
set -e

# Define color and style variables
BOLD=$(tput bold)
RESET=$(tput sgr0)
YELLOW="\033[1;33m"

# Function to echo styled messages
echo_styled() {
    echo "\n${BOLD}${YELLOW}$1${RESET}\n"
}

echo_styled "Updating package list..."
sudo apt update -y

echo_styled "Updating packages..."
sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt full-upgrade -y

echo_styled "Cleaning up..."
sudo apt autoremove -y && sudo apt autoclean -y

echo_styled "Installing essential linux packages..."
sudo apt install -y \
    python3-pip \
    python3-venv \
    python3-setuptools \
    python3-wheel \
    python3-packaging \
    ipython3 \
    zsh

echo_styled "Setting ZSH as default shell..."
chsh -s $(which zsh)

echo_styled "Installing Oh My Zsh framework..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo_styled "Cloning ZSH plugins (zsh-autosuggestions and zsh-syntax-highlighting)..."
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo_styled "Cloning powerlevel10k theme for Oh My Zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Replacing the current shell process with a new ZSH process, reading updated .zshrc config file
echo_styled "Done"
exec zsh -l

