autoload -Uz compinit && compinit
bindkey -e
bindkey \^U backward-kill-line
export WORDCHARS="_"
autoload -U select-word-style
select-word-style bash

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# You may need to manually set your language environment

export EDITOR="nvim"
alias ls="ls -G"
alias ll='ls -hAlFG'
alias l="ls -lCFG"
alias la="ls -AG"
alias cl="clear"
alias vi="nvim"

export VIRTUAL_ENV_DISABLE_PROMPT=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
alias taunt='echo "σ\`∀´)σ"'
export PKG_CONFIG_PATH="/opt/homebrew/opt/openal-soft/lib/pkgconfig:/opt/homebrew/opt/libffi/lib/pkgconfig"
. "$HOME/.cargo/env"
if command -v oh-my-posh >/dev/null; then
	eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/robbyrussell.omp.json)"
fi
echo "σ\`∀´)σ"
