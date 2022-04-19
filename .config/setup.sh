#!/bin/sh

chsh -s /usr/bin/zsh

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

#HOST=commander
#DISPLAY_NUMBER=$(echo $DISPLAY | cut -d. -f1 | cut -d: -f2)
#AUTH_COOKIE=$(xauth list | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " | awk '{print $3}')
#xauth add ${HOST}/unix:${DISPLAY_NUMBER} MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}
