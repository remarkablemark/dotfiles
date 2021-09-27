#!/bin/bash

echo 'Setup start.'

# check for macOS
if [[ $OSTYPE != 'darwin'* ]]; then
  echo "Expected macOS, but received $OSTYPE. Aborting installation."
  exit 1
fi

# disable last login message
touch ~/.hushlogin

# install brew: https://brew.sh/
if [[ $(command -v brew) == '' ]]; then
  echo 'Installing homebrew...'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install git
if [[ $(command -v git) != '/usr/local/bin/git' ]]; then
  echo 'Installing git...'
  brew install git
fi

# install vim
if [[ $(command -v vim) != '/usr/local/bin/vim' ]]; then
  echo 'Installing vim...'
  brew install vim
fi

mkdir -p ~/.vim
ln -sf "$(pwd)/vimrc" ~/.vim/vimrc
ln -sf "$(pwd)/bundle" ~/.vim/bundle

# set up global git config
echo 'Setting up global git config...'
git config --global user.name 'Mark'
git config --global user.email 'mark@remarkablemark.org'
git config --global core.editor $(which vim)
git config --global color.ui auto
git config --global core.ignorecase false
git config --global pager.branch false

# show global git config
git config --global --list | cat

# global gitignore
ln -sf "$(pwd)/gitignore" ~/.gitignore
git config --global core.excludesfile ~/.gitignore

# install zsh
if [[ $(command -v zsh) == '' ]]; then
  echo 'Installing zsh...'
  brew install zsh
fi

# install Oh My Zsh: https://github.com/ohmyzsh/ohmyzsh
if ! [[ -d ~/.oh-my-zsh/ ]]; then
  echo 'Installing Oh My Zsh...'
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo 'Copying and updating Oh My Zsh config...'
# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-400571406
echo 'ZSH_DISABLE_COMPFIX=true' > ~/.zshrc
echo '' >> ~/.zshrc
cat ~/.oh-my-zsh/templates/zshrc.zsh-template >> ~/.zshrc
sed -i '' 's/robbyrussell/sammy/' ~/.zshrc
echo '' >> ~/.zshrc
cat zshrc >> ~/.zshrc
source ~/.zshrc

# install Vundle
if ! [[ -d bundle/Vundle.vim/ ]]; then
  echo 'Installing Vundle...'
  git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim

  echo 'Installing Vim plugins via Vundle...'
  vim +PluginInstall +qall
  echo 'Vim plugins installed.'
fi


# compile Vim plugin YouCompleteMe: https://github.com/ycm-core/YouCompleteMe#macos
if [[ $(grep 'YouCompleteMe' vimrc) != '' ]]; then
  # dependencies required to build plugin
  if [[ $(command -v cmake) == '' ]]; then
    echo 'Installing cmake...'
    brew install cmake
  fi

  if [[ $(command -v go) == '' ]]; then
    echo 'Installing go...'
    brew install go
  fi

  if [[ $(command -v python3) == '' ]]; then
    echo 'Installing python3...'
    brew install python3
  fi

  if ! test -n $(find bundle/YouCompleteMe/third_party/ycmd -type f -name "ycm_core*.so" -maxdepth 1); then
    echo 'Compiling YouCompleteMe...'
    python3 bundle/YouCompleteMe/install.py --all
  fi
fi

# install tmux
if [[ $(command -v tmux) == '' ]]; then
  echo 'Installing tmux...'
  brew install tmux
fi

# install tmux wrapper for copying/pasting to session clipboard
if [[ $(command -v reattach-to-user-namespace) == '' ]]; then
  echo 'Installing reattach-to-user-namespace...'
  brew install reattach-to-user-namespace
fi

echo 'Copying tmux config...'
cp tmux.conf ~/.tmux.conf
tmux source-file ~/.tmux.conf

# install The Silver Searcher: https://github.com/ggreer/the_silver_searcher
if [[ $(command -v ag) == '' ]]; then
  echo 'Installing The Silver Searcher...'
  brew install the_silver_searcher
fi

# install Node.js
if [[ $(command -v node) == '' ]]; then
  echo 'Installing node...'
  brew install node
fi

# install nvm: https://github.com/nvm-sh/nvm
if ! [[ -d ~/.nvm/ ]]; then
  echo 'Installing nvm...'
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
fi

# install Yarn
if [[ $(command -v yarn) == '' ]]; then
  echo 'Installing yarn...'
  brew install yarn
fi

# install rbenv
if [[ $(command -v rbenv) == '' ]]; then
  # ruby depends on openssl
  if [[ $(command -v openssl) == '' ]]; then
    echo 'Installing openssl...'
    brew install openssl
  fi

  echo 'Installing rbenv...'
  brew install rbenv
fi

# install java
if [[ $(command -v java) == '' ]]; then
  echo 'Installing java...'
  brew install java
fi

# restart shell
echo 'Setup end.'
exec -l $SHELL
