#!/bin/bash


while read -r line; do
    package=$(echo "$line" | cut -d ':' -f 1)
    installed=$(echo "$line" | cut -d ':' -f 2)
    installed=$(echo "$installed" | tr -d ' ')  # Remove leading/trailing whitespace

    # If the package is not installed, remove it
    if [ "$installed" = "false" ]; then
        apt remove -y "$package"
    fi
done < ~/.config/pluginlist/backup.yaml

sed -i '/exec zsh/d' ~/.bashrc

rm -rf ~/.config ~/.local ~/.tmux ~/.cache
rm ~/.tmux.conf ~/.zprofile ~/.zshrc 
mv ~/.old/* ~/
rm -rf ~/.old
rm ~/.vscode-server/data/Machine/settings.json
[ ! -f ~/settings.json ] || mv ~/settings.json ~/.vscode-server/data/Machine/settings.json