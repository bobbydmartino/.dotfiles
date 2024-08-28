#!/bin/bash

set -euo pipefail

# Define the repository URL and the local directory
REPO_URL="https://github.com/bobbydmartino/.dotfiles"
SSH_URL="git@github.com:bobbydmartino/.dotfiles.git"
LOCAL_DIR="$HOME/.dotfiles"
export DEBIAN_FRONTEND=noninteractive


# Check if the first argument is '--update'
if [ "$1" == "--update" ]; then
    # Check if the local directory exists and is a git repository
    if [ -d "$LOCAL_DIR/.git" ]; then
        # Change to the local directory
        cd "$LOCAL_DIR"

        # Check if the local repository is synced with the remote repository
        git fetch
        UPSTREAM=${2:-'@{u}'}
        LOCAL=$(git rev-parse @)
        REMOTE=$(git rev-parse "$UPSTREAM")
        BASE=$(git merge-base @ "$UPSTREAM")

        if [ $LOCAL = $REMOTE ]; then
            echo "The repository is up-to-date."
        elif [ $LOCAL = $BASE ]; then
            echo "Updating the repository..."
            git pull
        else
            echo "The local repository is not in sync with the remote. Deleting and cloning the repository..."
            rm -rf "$LOCAL_DIR"
            git clone "$SSH_URL" "$HOME"
        fi
    else
        echo "The local directory does not exist or is not a git repository. Cloning the repository..."
        rm -rf "$LOCAL_DIR"
        git clone "$REPO_URL" "$HOME"
    fi
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install it to continue."
    exit 1
fi

# check if ssh is available, else clone with https
if ssh -T git@github.com; then
  git clone git@github.com:bobbydmartino/.dotfiles.git
else
  git clone https://github.com/bobbydmartino/.dotfiles.git
fi
# prompt user what system they are on: mac|unix|docker|unixnosudo
echo "Which system are you on?"
echo "1) Mac"
echo "2) Linux"
echo "3) Docker"
echo "4) Linux (no sudo)"
read -p "Enter the number of your system: " number

# Assign the corresponding string to the system variable
if [ $number -eq 1 ]; then
  system="mac"
  if [ ! command -v brew &> /dev/null ]; then
    echo "INSTALL HOMEBREW"
    exit 1
  fi
elif [ $number -eq 2 ]; then
  system="linux"
elif [ $number -eq 3 ]; then
  system="docker"
  echo "Note: Add 'RUN apt-get update && apt-get install -y curl wget git apt-utils && \\"
  echo "wget -O - https://raw.githubusercontent.com/bobbydmartino/.dotfiles/main/docker_install.sh | bash' to your Dockerfile instead"
  echo "Continuing anyway..."
  apt update
elif [ $number -eq 4 ]; then
  system="linuxnosudo"
else
  echo "Invalid input. Exiting script."
  exit 1
fi  

# touch .df_backup.yaml and bash aliases
mkdir -p ~/.df_backup
touch ~/.bash_aliases
touch ~/.df_backup/.backup.yaml

# add system type to .dotfiles.yaml
echo "system: $system" > ~/.df_backup/.backup.yaml

# check what is installed on system, write to backup file
is_installed() {
  if [ $system = "mac" ]; then
    # Use the 'brew list' command to check if the package is installed on Mac
    if command -v "$1" &> /dev/null; then
        echo "true"
    else
        echo "false"
    fi
  else
    dpkg -s "$1" &> /dev/null && echo "true" || echo "false"
  fi
}

write_to_yaml() {
    package=$1
    if $(is_installed $package); then
        echo "$package:true" >> ~/.df_backup/.backup.yaml
    else
        echo "$package:false" >> ~/.df_backup/.backup.yaml
    fi
}
if [ $system = "mac" ]; then
    while read package; do
      write_to_yaml "$package"
    done < $PWD/.dotfiles/.config/install_list/.mackagelist
else
    while read package; do
      write_to_yaml "$package"
    done < $PWD/.dotfiles/.config/install_list/.packagelist
fi


# install what is still needed if possible (unixnosudo print which ones need to be installed and exit)
while read line; do
  package=$(echo $line | cut -d ":" -f 1)
  installed=$(echo $line | cut -d ":" -f 2)
  if [ $installed = "false" ]; then
    if [ $system = "docker" ]; then
      DEBIAN_FRONTEND=noninteractive apt install -y $package
    elif [ $system = "linux" ]; then
      sudo DEBIAN_FRONTEND=noninteractive apt install -y $package
    elif [ $system = "mac" ]; then
      brew install $package
    elif [ $system = "linuxnosudo" ]; then
      echo "The package $package needs to be installed, please ask your system administrator to install it."
    fi
  else
    echo $package $installed
  fi
done < ~/.df_backup/.backup.yaml

if [ $system = "linux" ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    sudo apt-get install -y nodejs
elif [ $system = "docker" ]; then
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt-get install -y nodejs
elif [ $system = "linuxnosudo" ]; then
    echo "The package Nodejs needs to be installed, please ask your system administrator to install it."
fi

# add existing conflicting dotfiles to backup and mv to ~/.df_backup/
[ ! -d ~/.local ] || mv ~/.local ~/.df_backup/.local
[ ! -d ~/.config ] || mv ~/.config ~/.df_backup/.config
[ ! -f ~/.zprofile ] || mv ~/.zprofile ~/.df_backup/.zprofile
[ ! -f ~/.zshrc ] || mv ~/.zshrc ~/.df_backup/.zshrc
[ ! -f ~/.tmux.conf ] || mv ~/.tmux.conf ~/.df_backup/.tmux.conf
[ ! -d ~/.tmux ] || mv ~/.tmux ~/.df_backup/.tmux
[ ! -f ~/.isort.cfg ] || mv ~/.isort.cfg ~/.df_backup/.isort.cfg

# Install LazyVim
git clone https://github.com/LazyVim/starter "$HOME/.dotfiles/.config/nvim"
rm -rf "$HOME/.dotfiles/.config/nvim/.git"

# create lf cache
mkdir -p $HOME/.cache/lf
touch $HOME/.cache/history
touch $HOME/.bash_aliases

# Link dotfiles (excluding Neovim config which is now managed by LazyVim)
ln -sf "$HOME/.dotfiles/.local" "$HOME/.local"
ln -sf "$HOME/.dotfiles/.config/shell/profile" "$HOME/.zprofile"
ln -sf "$HOME/.dotfiles/.config/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/.config/tmux/" "$HOME/.tmux"
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

if [ $system = "mac" ]; then
    echo "NVIM already installed"
elif [ $system = "linux" ]; then
    # Install Neovim
    sudo apt-get update && sudo apt-get install -y software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install -y neovim

    # Install imgcat for using iterm2's image viewing functionality over ssh
    pip install imgcat black isort
else
    # Install Neovim
    apt-get update && apt-get install -y software-properties-common
    add-apt-repository ppa:neovim-ppa/unstable
    apt-get update
    apt-get install -y neovim
    
    # Install imgcat for using iterm2's image viewing functionality over ssh
    pip install imgcat black isort
fi

# Initial setup of LazyVim
nvim --headless "+Lazy! sync" +qa

export PATH=$PATH:~/.local/bin/ 
echo exec zsh >> ~/.bashrc
