# My Dotfiles
###### (This readme was written by ChatGPT, so some of the links may have been hallucinated)

My dotfiles are a collection of configuration files that I use to personalize my development environment.

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

## Tmux

My dotfiles include a customized `.tmux.conf` file that I use to personalize my tmux terminal multiplexer. This configuration file is based on the popular [tmux project](https://github.com/tmux/tmux) and it maps the default `ctrl-b` to `ctrl-space` for more comfortable use.

It uses [`tpm`](https://github.com/tmux-plugins/tpm) as the plugin manager, and it uses [`tmux-resurrect`](https://github.com/tmux-plugins/tmux-resurrect) and [`tmux-sessionist`](https://github.com/tmux-plugins/tmux-sessionist) for session management, which saves and restores tmux sessions.

The status line is on top, on the top left it shows the sessions available, in the center shows the windows, and on the right shows the time, the current session and window are highlighted. The prefix `j` and `k` cycle between windows and prefix `J` and `K` cycle between sessions.

The `.tmux.conf` is well-documented, so you can look there for any questions you may have. 
Please note that you may need to install the plugins and dependencies mentioned in this section in order for the tmux to work properly.

You can find more information about `tmux` on the [official website](https://github.com/tmux/tmux) and the [documentation](https://manpages.debian.org/testing/tmux/tmux.1.en.html)

## Neovim

My dotfiles include a customized configuration for [`neovim`](https://github.com/neovim/neovim), which is the editor I use.

The `neovim` appimage is located in `.local/bin` and the `oneliner.sh` extracts it and symlinks it so that you don't need to have it installed on your system, and that it guarantees the latest version of neovim. 

My `init.lua` first loads `.config/nvim/lua/ide/plugins.lua`, which uses [`packer`](https://github.com/wbthomason/packer.nvim) to install all of the plugins. 

It then requires the sets and remaps that I have defined. The plugins that I use are mostly focused on turning `neovim` into a lightweight Python IDE, but such that it is also very easy to edit plain text files.

The plugins I use are:
- [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter) for syntax highlighting
- [`undotree`](https://github.com/mbbill/undotree) for long running undo's to files
- [`vim-fugitive`](https://github.com/tpope/vim-fugitive) for git integration
- [`vim-surround`](https://github.com/tpope/vim-surround) for surrounding text with quotes and brackets
- [`nvim-autopairs`](https://github.com/jiangmiao/auto-pairs) for automatically having the complement to any punctuation
- [`vimwiki`](https://github.com/vimwiki/vimwiki) for notes
- [`nvim-tree`](https://github.com/jianjunjiu/nvim-tree) for navigation (use Ctrl-n to toggle)
- [`bufferline`](https://github.com/akinsho/bufferline.nvim) for adding a more sublime feel (pun intended) use H and L to toggle between them
- [`harpoon`](https://github.com/theprimeagen/harpoon) for better navigation and file management.
- [`telescope`](https://github.com/nvim-lua/telescope.nvim) for fuzzy finding
- [`copilot`](https://github.com/nvim-lua/copilot.nvim) for AI-assisted coding.
- [`nvim-dap`](https://github.com/mfussenegger/nvim-dap) and [`nvim-dap-ui`](https://github.com/mfussenegger/nvim-dap-ui) for debugging.
- [`tagbar`](https://github.com/majutsushi/tagbar) for navigating large files
- [`lsp-zero`](https://github.com/lsp-zero/lsp-zero) for handling autocomplete (makes it super easy)
- Aesthetic plugins are [`vim-airline`](https://github.com/vim-airline/vim-airline) and [`awesome-vim-colorschemes`](https://github.com/rafi/awesome-vim-colorschemes)

Please see the plugin folder in `.config/nvim/after/plugin` for the specific configurations of each of these plugins.
Please note that you may need to install the plugins and dependencies mentioned in this section in order for the neovim to work properly.
You can find more information about `neovim` on the [official website](https://github.com/neovim/neovim) and the [documentation](https://neovim.io/doc/)

## Customize

You can customize the dotfiles by editing the files in the repository. The changes will be automatically reflected in your development environment.

## Uninstall
Currently the `oneliner.sh` stores all the changes it made in `~/.dotfiles_backup`

I am working (not terribly hard mind you) on eventually writing an uninstall script that gets your system right back to the way it was.

When it exists (if?) you will be able to uninstall the dotfiles with the following command:
`./uninstall.sh`

This command will remove all the symbolic links and restore your original configuration files.

## Contribute

I am always open to contributions and suggestions to improve the dotfiles. If you have any ideas or found any bugs, feel free to open an issue or submit a pull request.

Enjoy the use of my dotfiles!
