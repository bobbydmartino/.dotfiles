#!/bin/bash

rm -f $PWD/.config/pluginlist/backup.yaml
#track what already exists and save to backup.yaml

# Check if a package is installed
is_installed() {
    dpkg -s "$1" >/dev/null 2>&1
}

# Write the name of the package and whether it's installed to a YAML file
write_to_yaml() {
    if is_installed "$1"; then
        echo "$1: true" >> $PWD/.config/pluginlist/backup.yaml
    else
        echo "$1: false" >> $PWD/.config/pluginlist/backup.yaml
    fi
}

# Call the function for each package you want to check
write_to_yaml neofetch
write_to_yaml sxiv
write_to_yaml tmux
write_to_yaml wget
write_to_yaml zsh
write_to_yaml sudo
write_to_yaml sxiv
write_to_yaml mediainfo
write_to_yaml bat
write_to_yaml curl
write_to_yaml rsync
write_to_yaml git
write_to_yaml zathura
write_to_yaml mpv 
write_to_yaml python3-pip
write_to_yaml trash-cli
write_to_yaml neofetch
write_to_yaml graphicsmagick
write_to_yaml ffmpegthumbnailer

apt-get update
while read -r line; do
    package=$(echo "$line" | cut -d ':' -f 1)
    installed=$(echo "$line" | cut -d ':' -f 2)
    installed=$(echo "$installed" | tr -d ' ')  # Remove leading/trailing whitespace

    # If the package is not installed, remove it
    if [ "$installed" = "false" ]; then
        apt-get install -y "$package"
    fi
done < $PWD/.config/pluginlist/backup.yaml



# mv .config and .local to .old/.config and .old/.local along with .zprofile, .zshrc, .tmux.conf, .tmux
mkdir -p ~/.old
[ ! -d ~/.local ] || mv ~/.local ~/.old/.local
[ ! -d ~/.config ] || mv ~/.config ~/.old/.config
[ ! -f ~/.zprofile ] || mv ~/.zprofile ~/.old/.zprofile
[ ! -f ~/.zshrc ] || mv ~/.zshrc ~/.old/.zshrc
[ ! -f ~/.tmux.conf ] || mv ~/.tmux.conf ~/.old/.tmux.conf
[ ! -d ~/.tmux ] || mv ~/.tmux ~/.old/.tmux

ln -sf $PWD/.local ~/.local
ln -sf $PWD/.config ~/.config

mkdir -p ~/.cache
mkdir -p ~/.cache/zsh
touch ~/.cache/history

ln -sf ~/.config/shell/profile ~/.zprofile
ln -sf ~/.config/zsh/.zshrc ~/.zshrc
ln -sf ~/.config/tmux/.tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux/
export PATH=$PATH:~/.local/bin/ 
ln -sf ~/.config/tmux/plugins/ ~/.tmux/plugins
ln -sf ~/.config/tmux/resurrect ~/.tmux/resurrect

# #INSTALL PLUGINS FROM SOURCE
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

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -sf ~/.vim/autoload ~/.config/nvim/autoload

# #add exec zsh to end of bashrc for tmux
echo "exec zsh" >> ~/.bashrc
