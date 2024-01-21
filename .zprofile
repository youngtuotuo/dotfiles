
eval "$(/opt/homebrew/bin/brew shellenv)"

case ":${PATH}:" in
    *:"$HOME/.local/bin":*)
        ;;
    *)
        export PATH="$HOME/.local/bin${PATH:+:${PATH}}"
        ;;
esac

# export PATH
case ":${MANPATH}:" in
    *:"/usr/local/man":*)
        ;;
    *)
        export MANPATH="/usr/local/man${MANPATH:+:${MANPATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"/opt/homebrew/opt/binutils/bin":*)
        ;;
    *)
        export PATH="/opt/homebrew/opt/binutils/bin${PATH:+:${PATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"/opt/homebrew/opt/llvm/bin":*)
        ;;
    *)
        export PATH="/opt/homebrew/opt/llvm/bin${PATH:+:${PATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"/Library/Frameworks/Python.framework/Versions/3.11/bin":*)
        ;;
    *)
        export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin${PATH:+:${PATH}}"
        ;;
esac


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH
