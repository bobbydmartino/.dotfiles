# My Dotfiles

My dotfiles is a collection of configuration files that I use to personalize my development environment. It includes my `.zshrc`, `.zprofile`, `.tmux.conf`, and others.

## Install

To install the dotfiles, you can use the following command:
`curl -L -o oneliner.sh shorturl.at/cefJ1 && chmod +x oneliner.sh && ./oneliner.sh`

This command will automatically install the dotfiles for you, and it's compatible with different operating system.

Please note that the installation process will replace your current `.zshrc`, `.zprofile`, `.tmux.conf` files with symbolic links to the corresponding files in this repository. It will also create symbolic links to `.config` and `.local` in your home directory.

After the installation, you can start using the dotfiles by opening a new terminal window or running `source ~/.zshrc`.

## Customize

You can customize the dotfiles by editing the files in the repository. The changes will be automatically reflected in your development environment.

## Uninstall

To uninstall the dotfiles, you can run the following command:
`./uninstall.sh`

This command will remove all the symbolic links and restore your original configuration files.

## Contribute

I am always open to contributions and suggestions to improve the dotfiles. If you have any ideas or found any bugs, feel free to open an issue or submit a pull request.

Enjoy the use of my dotfiles!
