##
# Custom
##

# https://github.com/ohmyzsh/ohmyzsh/issues/6835
ZSH_DISABLE_COMPFIX=true

# /usr/bin must not occur before /usr/local/bin in your PATH
# otherwise system-provided programs will be used instead of those
# provided by Homebrew
export PATH="/usr/local/bin:$PATH"

# Ruby needs to be compiled with the latest OpenSSL
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

# Load rbenv automatically by appending
# the following to ~/.zshrc:
eval "$(rbenv init -)"

# Java (JDK)
export PATH="/usr/local/opt/java/bin:$PATH"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
