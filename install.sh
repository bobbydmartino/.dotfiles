
#!/bin/bash


#TODO: track what already exists and save to backup.yaml

# if [ ! -f "/usr/share/fonts/JetBrains Mono Bold Nerd Font Complete.ttf" ]
# then
# 	curl -fLo "/usr/share/fonts/JetBrains Mono Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Bold/complete/JetBrains%20Mono%20Bold%20Nerd%20Font%20Complete.ttf
# 	curl -fLo "/usr/share/fonts/JetBrains Mono Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Italic/complete/JetBrains%20Mono%20Italic%20Nerd%20Font%20Complete.ttf
# 	curl -fLo "/usr/share/fonts/JetBrains Mono Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf
# fi

#if sudo isnt installed, probably docker container, install without
# apt-get update && apt-get install -y \
# 	tmux \
# 	wget \
# 	zsh \
# 	sudo \
# 	sxiv \
# 	mediainfo \
# 	bat \
# 	curl \
# 	rsync \
# 	git \
# 	zathura \
# 	mpv \
# 	python3-pip \
# 	trash-cli \
# 	neofetch \
# 	graphicsmagick \
# 	ffmpegthumbnailer 
# else install with sudo





# # mv .config and .local to .old/.config and .old/.local along with .zprofile, .zshrc, .tmux.conf, .tmux
# mkdir -p ~/.old
# [ ! -d ~/.local ] || mv ~/.local ~/.old/.local
# [ ! -d ~/.config ] || mv ~/.config ~/.old/.config
# [ ! -f ~/.zprofile ] || mv ~/.zprofile ~/.old/.zprofile
# [ ! -f ~/.tmux.conf ] || mv ~/.tmux.conf ~/.old/.tmux.conf
# [ ! -d ~/.tmux ] || mv ~/.tmux ~/.old/.tmux

# ln -sf $PWD/.local ~/.local
# ln -sf $PWD/.config ~/.config

# mkdir -p ~/.cache
# mkdir -p ~/.cache/zsh
# touch ~/.cache/history

# ln -sf ~/.config/shell/profile ~/.zprofile
# ln -sf ~/.config/zsh/.zshrc ~/.zshrc
# ln -sf ~/.config/tmux/.tmux.conf ~/.tmux.conf
# mkdir -p ~/.tmux/
# export PATH=$PATH:~/.local/bin/ 
# ln -sf ~/.config/tmux/plugins/ ~/.tmux/plugins
# ln -sf ~/.config/tmux/resurrect ~/.tmux/resurrect

# #check if .vscode-server is installled
if [ -d ~/.vscode-server ]; then 
  ln -sf ~/.config/vscode/settings.json ~/.vscode-server/data/Machine/settings.json
else
  #call download-vs-code-server.sh
fi


#   #if not install vscode server somehow
#   #if so then install extensions for programming

# #INSTALL PLUGINS FROM SOURCE
# while IFS="" read -r p || [ -n "$p" ]
# do
#   arrIN=(${p// / })
#   mkdir -p ".config/${arrIN[0]}"
#   mkdir -p ".config/${arrIN[0]}/plugins/"

#   if [ ! -d ".config/${arrIN[0]}/plugins/${arrIN[1]}" ]
#   then
#           git clone ${arrIN[2]} ".config/${arrIN[0]}/plugins/${arrIN[1]}"
#   fi
# done < ~/.config/plugins/.pluginlist


# chsh -s /usr/bin/zsh
