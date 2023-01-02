#!/bin/bash


#TODO: track what already exists and save to backup.yaml

if [ ! -f "/usr/share/fonts/JetBrains Mono Bold Nerd Font Complete.ttf" ]
then
	curl -fLo "/usr/share/fonts/JetBrains Mono Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Bold/complete/JetBrains%20Mono%20Bold%20Nerd%20Font%20Complete.ttf
	curl -fLo "/usr/share/fonts/JetBrains Mono Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Italic/complete/JetBrains%20Mono%20Italic%20Nerd%20Font%20Complete.ttf
	curl -fLo "/usr/share/fonts/JetBrains Mono Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf
fi

sudo apt-get update && sudo apt-get install -y \
	tmux \
	wget \
	zsh \
	sxiv \
	mediainfo \ 
	bat \
	curl \
	rsync \
	git \
	zathura \
	mpv \
	python3-pip \
	trash-cli \
	neofetch \
	graphicsmagick \
	ffmpegthumbnailer 


# mv .config and .local to .old/.config and .old/.local along with .zprofile, .zshrc, .tmux.conf, .tmux

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

#check if .vscode-server is installled
  #if not install vscode server somehow
  #if so then install extensions for programming

#INSTALL PLUGINS FROM SOURCE
while IFS="" read -r p || [ -n "$p" ]
do
  arrIN=(${p// / })

  
  mkdir -p ".config/${arrIN[0]}"
  mkdir -p ".config/${arrIN[0]}/plugins/"

  if [ ! -d ".config/${arrIN[0]}/plugins/${arrIN[1]}" ]
  then
          git clone ${arrIN[2]} ".config/${arrIN[0]}/plugins/${arrIN[1]}"
  fi
done < .config/plugins/.pluginlist


chsh -s /usr/bin/zsh
