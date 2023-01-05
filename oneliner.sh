#!/bin/bash

git clone https://github.com/bobbydmartino/dotfiles.git
cd dotfiles
./install.sh
exec zsh
