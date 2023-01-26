#!/bin/bash

# check if ssh is available, else clone with https
if ssh -T git@github.com; then
  git clone git@github.com:bobbydmartino/dotfiles.git
else
  git clone https://github.com/bobbydmartino/dotfiles.git
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

# touch .df_backup.yaml and bash aliases
mkdir -p ~/.dotfiles_backup
touch ~/.bash_aliases
touch ~/.dotfiles_backup/.backup.yaml

# add system type to .dotfiles.yaml
echo "system: $system" > ~/.dotfiles_backup/.backup.yaml

# check what is installed on system, write to backup file
is_installed() {
  if [ $system = "mac" ]; then
    # Use the 'brew list' command to check if the package is installed on Mac
    if brew list -1 | grep -q "^$1\$"; then
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
        echo "$package:true" >> ~/.dotfiles_backup/.backup.yaml
    else
        echo "$package:false" >> ~/.dotfiles_backup/.backup.yaml
    fi
}

while read package; do
  write_to_yaml "$package"
done < $PWD/dotfiles/.config/pluginlist/.packagelist

# install what is still needed if possible (unixnosudo print which ones need to be installed and exit)
while read line; do
  package=$(echo $line | cut -d ":" -f 1)
  installed=$(echo $line | cut -d ":" -f 2)
  if [ $installed = "false" ]; then
    if [ $system = "docker" ]; then
      apt install -y $package
    elif [ $system = "linux" ]; then
      sudo apt install -y $package
    elif [ $system = "mac" ]; then
      brew install $package
    elif [ $system = "linuxnosudo" ]; then
      echo "The package $package needs to be installed, please ask your system administrator to install it."
    fi
  else
    echo $package $installed
  fi
done < ~/.dotfiles_backup/.backup.yaml


# add existing conflicting dotfiles to backup and mv to ~/.dotfiles_backup/
[ ! -d ~/.local ] || mv ~/.local ~/.dotfiles_backup/.local
[ ! -d ~/.config ] || mv ~/.config ~/.dotfiles_backup/.config
[ ! -f ~/.zprofile ] || mv ~/.zprofile ~/.dotfiles_backup/.zprofile
[ ! -f ~/.zshrc ] || mv ~/.zshrc ~/.dotfiles_backup/.zshrc
[ ! -f ~/.tmux.conf ] || mv ~/.tmux.conf ~/.dotfiles_backup/.tmux.conf
[ ! -d ~/.tmux ] || mv ~/.tmux ~/.dotfiles_backup/.tmux

# link all dotfiles from repo to home directory
ln -sf $PWD/dotfiles/.local ~/.local
ln -sf $PWD/dotfiles/.config ~/.config

touch ~/.cache/history

ln -sf $PWD/dotfiles/.config/shell/profile ~/.zprofile
ln -sf $PWD/dotfiles/.config/zsh/.zshrc ~/.zshrc
ln -sf $PWD/dotfiles/.config/tmux/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/
export PATH=$PATH:~/.local/bin/ 
ln -sf $PWD/dotfiles/.config/tmux/plugins/ ~/.tmux/plugins
ln -sf $PWD/dotfiles/.config/tmux/resurrect ~/.tmux/resurrect

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
done < ~/.config/pluginlist/.pluginlist

# extract nvim image
cd ~/.local/bin && ./nvim.appimage --appimage-extract
cd ~

# nvm install nodejs
    # https://computingforgeeks.com/how-to-install-node-js-on-ubuntu-debian/
if [ $(is_installed "nodejs") == "false" ]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm install v16
fi

# create virtualenv depending on system for dap debugging
# create the virtualenvs directory
mkdir -p ~/.virtualenvs

# create the virtual environment
python3 -m venv ~/.virtualenvs/debugpy
~/.virtualenvs/debugpy/bin/python -m pip install -U debugpy

echo exec zsh >> ~/.bashrc
