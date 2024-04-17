#!/bin/bash

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
# Check for --dockerfile option
if [ "$1" == "--dockerfile" ]; then
    git clone https://github.com/bobbydmartino/.dotfiles.git
    system="linux"
else
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
      apt update
    elif [ $number -eq 4 ]; then
      system="linuxnosudo"
    else
      echo "Invalid input. Exiting script."
      exit 1
    fi  
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


# add existing conflicting dotfiles to backup and mv to ~/.df_backup/
[ ! -d ~/.local ] || mv ~/.local ~/.df_backup/.local
[ ! -d ~/.config ] || mv ~/.config ~/.df_backup/.config
[ ! -f ~/.zprofile ] || mv ~/.zprofile ~/.df_backup/.zprofile
[ ! -f ~/.zshrc ] || mv ~/.zshrc ~/.df_backup/.zshrc
[ ! -f ~/.tmux.conf ] || mv ~/.tmux.conf ~/.df_backup/.tmux.conf
[ ! -d ~/.tmux ] || mv ~/.tmux ~/.df_backup/.tmux
[ ! -f ~/.isort.cfg ] || mv ~/.isort.cfg ~/.df_backup/.isort.cfg

# link all dotfiles from repo to home directory
ln -sf $PWD/.dotfiles/.local ~/.local
ln -sf $PWD/.dotfiles/.config ~/.config

touch ~/.cache/history

# create lf cache
mkdir -p $HOME/.cache/lf

ln -sf $PWD/.dotfiles/.config/shell/profile ~/.zprofile
ln -sf $PWD/.dotfiles/.config/zsh/.zshrc ~/.zshrc
ln -sf $PWD/.dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
ln -sf $PWD/.dotfiles/.config/python/.isort.cfg ~/.isort.cfg
mkdir -p ~/.tmux/
export PATH=$PATH:~/.local/bin/ 
ln -sf $PWD/.dotfiles/.config/tmux/plugins/ ~/.tmux/plugins
ln -sf $PWD/.dotfiles/.config/tmux/resurrect ~/.tmux/resurrect

# install plugins script
while IFS="" read -r p || [ -n "$p" ]
do
  arrIN=(${p// / })


  mkdir -p ".config/${arrIN[0]}"
  mkdir -p ".config/${arrIN[0]}/plugins/"

  if [ ! -d ".config/${arrIN[0]}/plugins/${arrIN[1]}" ]
  then
          git clone ${arrIN[2]} ".config/${arrIN[0]}/plugins/${arrIN[1]}"
  fi
done < ~/.config/install_list/.pluginlist



if [ $system = "mac" ]; then
    echo "NVIM already installed"
else
    # extract nvim image
    cd ~/.local/bin && ./nvim.appimage --appimage-extract
    cd ~

    # Install imgcat for using iterm2's image viewing functionality over ssh
    pip install imgcat
fi


echo exec zsh >> ~/.bashrc
