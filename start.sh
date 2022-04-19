#!/bin/bash



if [ ! -f "/usr/share/fonts/JetBrains Mono Bold Nerd Font Complete.ttf" ]
then
	curl -fLo "/usr/share/fonts/JetBrains Mono Bold Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Bold/complete/JetBrains%20Mono%20Bold%20Nerd%20Font%20Complete.ttf
	curl -fLo "/usr/share/fonts/JetBrains Mono Italic Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Italic/complete/JetBrains%20Mono%20Italic%20Nerd%20Font%20Complete.ttf
	curl -fLo "/usr/share/fonts/JetBrains Mono Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/complete/JetBrains%20Mono%20Regular%20Nerd%20Font%20Complete.ttf
fi


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
done < .pluginlist


cp ~/.Xauthority .

docker-compose up -d --build
docker exec -it dotfiles_dot_1 /root/.config/setup.sh

