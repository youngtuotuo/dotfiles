# User configuration
bindkey -e

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# You may need to manually set your language environment

export EDITOR="nvim"
alias l="ls -l"
alias la="ls -a"

alias cl="clear"
alias vi="nvim"
fpath+=${ZDOTDIR:-~}/.zsh_functions

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
export VIRTUAL_ENV_DISABLE_PROMPT=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
