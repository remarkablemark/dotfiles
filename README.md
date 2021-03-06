# dotfiles

[remarkablemark's](https://b.remarkabl.org/github) [dotfiles](https://dotfiles.github.io/).

<details>
<summary>Table of Contents</summary>

- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Shell](#shell)
- [Vim](#vim)
- [iTerm2](#iterm2)
- [Directory Structure](#directory-structure)
- [License](#license)

</details>

## Prerequisites

> My dotfiles are only compatible with macOS.

If you have SSH access to the repository, then [set up your SSH key.](https://remarkablemark.org/blog/2020/04/13/avoid-ssh-passphrase/) and clone the repository:

```sh
git clone git@github.com:remarkablemark/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

If you don't have SSH access to the repository, then clone the repository:

```sh
git clone https://github.com/remarkablemark/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## Setup

Run [setup](https://github.com/remarkablemark/dotfiles/blob/master/setup.sh):

```sh
./setup.sh
```

If [Vundle](https://github.com/VundleVim/Vundle.vim) isn't installed, you can install it manually:

```sh
git clone https://github.com/VundleVim/Vundle.vim.git ~/dotfiles/bundle/Vundle.vim
vim +PluginInstall +qall
```

If [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe) isn't compiled, you can compile it manually:

```sh
python3 bundle/YouCompleteMe/install.py --all
```

## Shell

Verify the shell is `zsh`:

```sh
echo $SHELL
```

Reload the shell:

```sh
source ~/.zshrc
```

Or restart the shell:

```sh
exec -l $SHELL
```

## Vim

Reload vimrc in Vim:

```sh
vim ~/.vim/vimrc
```

```vim
:source %
```

## iTerm2

Download [iTerm2](https://iterm2.com/):

```sh
brew install --cask iterm2
```

Load preferences: **iTerm2** > **Preferences** > **General** > **Preferences** > **Load preferences from a custom folder or URL**: `~/dotfiles/`

Update profile: **iTerm2** > **Preferences** > **Profiles** > **Colors and Text**

Open tab in same directory: **iTerm2** > **Preferences** > **Profiles** > **Working Directory** > **Reuse previous session's directory**

## Directory Structure

```sh
tree -I bundle
```

```
.
????????? README.md
????????? com.googlecode.iterm2.plist
????????? gitignore
????????? powerline.tmux
????????? setup.sh
????????? tmux.conf
????????? vimrc
????????? zshrc

0 directories, 8 files
```

## License

[MIT](LICENSE)
