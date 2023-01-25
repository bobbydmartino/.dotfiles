# My Dotfiles

My dotfiles is a collection of configuration files that I use to personalize my development environment. It includes my `.zshrc`, `.zprofile`, `.tmux.conf`, and others.

## Install

To install the dotfiles, you can use the following command:  
`curl -L -o oneliner.sh shorturl.at/cefJ1 && chmod +x oneliner.sh && ./oneliner.sh`

This command will automatically install the dotfiles for you, and it's compatible with different operating systems.

Please note that the installation process will replace your current `.zshrc`, `.zprofile`, `.tmux.conf` files with symbolic links to the corresponding files in this repository. It will also create symbolic links to `.config` and `.local` in your home directory.

After the installation, you can start using the dotfiles by opening a new terminal window or running `source ~/.zshrc`.

### NOTE:
The Install requires you to install the packages in `.config/pluginlist/.packagelist` so you will need the ability to install them. The uninstall script will look at the backup file that is created and uninstall any packages that were installed during this process.

## Zsh

My dotfiles include a customized `.zshrc` file that I use to personalize my zsh shell. This configuration file is based on the popular [Oh My Zsh](https://ohmyz.sh/) framework, and includes some of its plugins, such as the [`fancy-ctrl-z`](https://github.com/ohmyzsh/ohmyzsh/tree/main/plugins/fancy-ctrl-z) plugin.

It also uses [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) for syntax highlighting in the terminal, and calls [`neofetch`](https://github.com/dylanaraps/neofetch) when the file is sourced.

In addition to that, it sources `.config/shell/aliasrc` and `.config/shell/profile`, which have aliases and environment variables that I like to use.

My zshrc also has the binding to ctrl-o, which opens my terminal file manager `lf` which is a terminal file manager that I use. This feature allows me to open files and directories using the keyboard, which is very convenient. I will explain more about `lf` in the next section.

Please note that you may need to install the plugins and dependencies mentioned in this section in order for the zshrc to work properly. They are installed automatically in the `oneliner.sh` file

## LF

My dotfiles include a customized configuration for [`lf`](https://github.com/gokcehan/lf), which is a terminal file manager that I use. `lf` is a powerful, feature-rich, and easy-to-use file manager that allows me to navigate and manage my files and directories with ease.

In my `.local/bin` I have a copy of the `lf` binary, which is used on Linux systems, but Mac users will have to install it via `brew install lf`. 

The file manager uses [`trash-cli`](https://github.com/andreafrancia/trash-cli) for deleting files. Also, the icons are defined in `.config/shell/profile`.

My `lfrc` is located in `.config/lf/lfrc` and contains other more specific bindings for how I use `lf`. I use `sxiv` for image previews and `bat` for file previews. Other functionality is forthcoming.

Please note that you may need to install the dependencies mentioned in this section in order for the `lf` to work properly.

You can find more information about `lf` on the [official website](https://github.com/gokcehan/lf) and the [documentation](https://github.com/gokcehan/lf/blob/main/README.md).



## Customize

You can customize the dotfiles by editing the files in the repository. The changes will be automatically reflected in your development environment.

## Uninstall

To uninstall the dotfiles, you can run the following command:
`./uninstall.sh`

This command will remove all the symbolic links and restore your original configuration files.

## Contribute

I am always open to contributions and suggestions to improve the dotfiles. If you have any ideas or found any bugs, feel free to open an issue or submit a pull request.

Enjoy the use of my dotfiles!
