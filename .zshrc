# User configuration
bindkey -e

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR="nvim"

alias cl="clear"
alias vi="nvim"
fpath+=${ZDOTDIR:-~}/.zsh_functions
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
# export PATH
export VIRTUAL_ENV_DISABLE_PROMPT=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/Users/mikehung/Library/Python/3.9/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
