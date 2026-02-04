##
# Custom
##

# /usr/bin must not occur before /usr/local/bin in your PATH
# otherwise system-provided programs will be used instead of those
# provided by Homebrew
export PATH="/usr/local/bin:$PATH"

# Ruby needs to be compiled with the latest OpenSSL
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

# Load rbenv automatically by appending
# the following to ~/.zshrc:
eval "$(rbenv init - zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm use >/dev/null 2>&1

# fzf
# https://github.com/junegunn/fzf#respecting-gitignore
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# Java
# https://docs.gradle.org/current/userguide/compatibility.html
# export JAVA_HOME=$(/usr/libexec/java_home -v 17)

# Homebrew
# https://docs.brew.sh/Analytics#opting-out
export HOMEBREW_NO_ANALYTICS=1
