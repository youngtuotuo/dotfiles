
eval "$(/opt/homebrew/bin/brew shellenv)"

# export PATH
case ":${PATH}:" in
    *:"/opt/homebrew/opt/binutils/bin":*)
        ;;
    *)
        export PATH="/opt/homebrew/opt/binutils/bin${PATH:+:${PATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"/opt/homebrew/opt/curl/bin":*)
        ;;
    *)
        export PATH="/opt/homebrew/opt/curl/bin${PATH:+:${PATH}}"
        ;;
esac
