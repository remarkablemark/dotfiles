#!/usr/bin/env bash

echo 'Setup start.'

# check for macOS
if [[ $OSTYPE != 'darwin'* ]]; then
  echo "Expected macOS, but received $OSTYPE. Aborting installation."
  exit 1
fi

# disable last login message
touch ~/.hushlogin

# install brew
# https://brew.sh/
if [[ ! $(command -v brew) ]]; then
  echo 'Installing homebrew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # add Homebrew to PATH
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# install git
if [[ ! $(command -v git) ]]; then
  echo 'Installing git...'
  brew install git
fi

# install vim
if [[ ! $(command -v vim) ]]; then
  echo 'Installing vim...'
  brew install vim
fi

if [[ ! -d ~/.vim ]]; then
  mkdir -p ~/.vim
  ln -sf "$(pwd)/after" ~/.vim/after
  ln -sf "$(pwd)/bundle" ~/.vim/bundle
  ln -sf "$(pwd)/vimrc" ~/.vim/vimrc
fi

# set up global git config
if [[ ! -f ~/.gitconfig ]]; then
  echo 'Setting up global git config...'
  ln -sf "$(pwd)/gitignore" ~/.gitignore
  git config --file .gitconfig core.editor $(which vim)
  git config --global include.path "$(pwd)/.gitconfig"
fi

# git config --global url.'https://'.insteadOf 'git://'
# git config --global --add url.'git@github.com:'.insteadOf 'https://github.com/'
# git config --global includeif.gitdir:~/.path=~/.gitconfig

# install git lfs
if [[ $(grep -L 'lfs' ~/.gitconfig) ]]; then
  echo 'Installing git lfs...'
  brew install git-lfs
  git lfs install
fi

# show global git config
git config --global --list | cat

# install zsh
if [[ ! $(command -v zsh) ]]; then
  echo 'Installing zsh...'
  brew install zsh
fi

# install Oh My Zsh
# https://github.com/ohmyzsh/ohmyzsh
if [[ ! -d ~/.oh-my-zsh/ ]]; then
  echo 'Installing Oh My Zsh...'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# copy and update Oh My Zsh config
if [[ ! -f ~/.zshrc ]]; then
  echo 'Copying and updating Oh My Zsh config...'
  # https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-400571406
  echo 'ZSH_DISABLE_COMPFIX=true' > ~/.zshrc
  echo '' >> ~/.zshrc
  cat ~/.oh-my-zsh/templates/zshrc.zsh-template >> ~/.zshrc
  sed -i '' 's/robbyrussell/sammy/' ~/.zshrc
  echo '' >> ~/.zshrc
  cat zshrc >> ~/.zshrc
  source ~/.zshrc
fi

# install Vundle
if [[ ! -d bundle/Vundle.vim/ ]]; then
  echo 'Installing Vundle...'
  git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim

  echo 'Installing Vim plugins via Vundle...'
  vim +PluginInstall +qall
  echo 'Vim plugins installed.'
fi

# install tmux
if [[ ! $(command -v tmux) ]]; then
  echo 'Installing tmux...'
  brew install tmux
fi

# install tmux wrapper for copying/pasting to session clipboard
if [[ ! $(command -v reattach-to-user-namespace) ]]; then
  echo 'Installing reattach-to-user-namespace...'
  brew install reattach-to-user-namespace
fi

echo 'Copying tmux config...'
cp tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf

# install nvm
# https://github.com/nvm-sh/nvm#install--update-script
if [[ ! -d ~/.nvm/ ]]; then
  echo 'Installing nvm...'
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
  nvm alias default node
fi

# install Yarn
if [[ ! $(command -v yarn) ]]; then
  echo 'Installing yarn...'
  brew install yarn
fi

# install rbenv
if [[ ! $(command -v rbenv) ]]; then
  # ruby depends on openssl
  if [[ ! $(command -v openssl) ]]; then
    echo 'Installing openssl...'
    brew install openssl
  fi

  echo 'Installing rbenv...'
  brew install rbenv
fi

# install java
if [[ ! $(command -v java) ]]; then
  echo 'Installing java...'
  brew install java
fi

# compile Vim plugin YouCompleteMe
# https://github.com/ycm-core/YouCompleteMe#macos
if [[ $(grep 'YouCompleteMe' vimrc) != '' ]]; then
  echo 'Installing YCM dependencies...'
  brew install cmake python go nodejs

  if ! test -n $(find bundle/YouCompleteMe/third_party/ycmd -type f -name "ycm_core*.so" -maxdepth 1); then
    echo 'Compiling YouCompleteMe...'
    python3 bundle/YouCompleteMe/install.py --all # --ts-completer
  fi
fi

# install fzf
if [[ ! $(command -v fzf) ]]; then
  echo 'Installing fzf...'
  brew install fzf
fi

# install fd
if [[ ! $(command -v fd) ]]; then
  echo 'Installing fd...'
  brew install fd
fi

# install The Silver Searcher (ag)
if [[ ! $(command -v ag) ]]; then
  echo 'Installing The Silver Searcher...'
  brew install the_silver_searcher
fi

# install ripgrep (rg)
if [[ ! $(command -v rg) ]]; then
  echo 'Installing ripgrep...'
  brew install rg
fi

# restart shell
echo 'Setup end.'
exec -l $SHELL
