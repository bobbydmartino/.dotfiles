#!/bin/bash

set -euo pipefail

# Clone dotfiles repository
git clone https://github.com/bobbydmartino/.dotfiles.git "$HOME/.dotfiles"

# Install packages from .packagelist
xargs -a "$HOME/.dotfiles/.config/install_list/.packagelist" apt-get install -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
apt-get install -y nodejs

# Install Python packages
pip install isort black imgcat

# Install Neovim
apt-get update && apt-get install -y software-properties-common
add-apt-repository ppa:neovim-ppa/unstable
apt-get update
apt-get install -y neovim

# Install LazyVim
git clone https://github.com/LazyVim/starter "$HOME/.dotfiles/.config/nvim"
rm -rf "$HOME/.config/nvim/.git"

# create lf cache
mkdir -p $HOME/.cache/lf
touch $HOME/.cache/history
touch $HOME/.bash_aliases

# Link dotfiles (excluding Neovim config which is now managed by LazyVim)
ln -sf "$HOME/.dotfiles/.local" "$HOME/.local"
ln -sf "$HOME/.dotfiles/.config/shell/profile" "$HOME/.zprofile"
ln -sf "$HOME/.dotfiles/.config/zsh/.zshrc" "$HOME/.zshrc"
mkdir -p ~/.tmux/
ln -sf "$HOME/.dotfiles/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$HOME/.dotfiles/.config/python/.isort.cfg" "$HOME/.isort.cfg"
ln -sf "$HOME/.dotfiles/.config" "$HOME/.config"


# Install custom configurations for LazyVim
mkdir -p "$HOME/.config/nvim/lua/plugins"
# Append custom configurations to LazyVim files
cat "$HOME/.dotfiles/.config/lazy/custom_init.lua" >> "$HOME/.config/nvim/init.lua"
cat "$HOME/.dotfiles/.config/lazy/custom_plugins.lua" >> "$HOME/.config/nvim/lua/plugins/custom.lua"

# Improved plugin installation script
PLUGIN_LIST="$HOME/.dotfiles/.config/install_list/.pluginlist"

if [ ! -f "$PLUGIN_LIST" ]; then
    echo "Plugin list file not found: $PLUGIN_LIST"
    exit 1
fi

while IFS= read -r line || [ -n "$line" ]; do
    if [ -z "$line" ]; then
        continue
    fi

    read -ra parts <<< "$line"
    if [ ${#parts[@]} -ne 3 ]; then
        echo "Invalid line format: $line"
        continue
    fi

    app="${parts[0]}"
    plugin="${parts[1]}"
    repo="${parts[2]}"

    plugin_dir="$HOME/.dotfiles/.config/$app/plugins/$plugin"
    
    if [ ! -d "$plugin_dir" ]; then
        echo "Installing plugin: $plugin for $app"
        mkdir -p "$(dirname "$plugin_dir")"
        if ! git clone "$repo" "$plugin_dir"; then
            echo "Failed to clone $repo"
        fi
    else
        echo "Plugin already installed: $plugin for $app"
    fi
done < "$PLUGIN_LIST"

# Set ZSH as default shell
chsh -s "$(which zsh)"

# Initial setup of LazyVim

nvim --headless "+Lazy! sync" +qa
export PATH=$PATH:~/.local/bin/ 
echo exec zsh >> ~/.bashrc
