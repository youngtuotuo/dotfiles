
eval "$(/opt/homebrew/bin/brew shellenv)"

# case ":${PATH}:" in
# *:"$HOME/.local/zig":*) ;;
# *)
#     export PATH="$HOME/.local/zig${PATH:+:${PATH}}"
#     ;;
# esac

# export PATH
case ":${PATH}:" in
    *:"/opt/homebrew/opt/binutils/bin":*)
        ;;
    *)
        export PATH="/opt/homebrew/opt/binutils/bin${PATH:+:${PATH}}"
        ;;
esac
# case ":${PATH}:" in
#     *:"/Users/mikehung/.rubies/ruby-3.1.3/bin":*)
#         ;;
#     *)
#         export PATH="/Users/mikehung/.rubies/ruby-3.1.3/bin${PATH:+:${PATH}}"
#         ;;
# esac

case ":${PATH}:" in
    *:"/opt/homebrew/opt/curl/bin":*)
        ;;
    *)
        export PATH="/opt/homebrew/opt/curl/bin${PATH:+:${PATH}}"
        ;;
esac


# export MODULAR_HOME="$HOME/.modular"
#
# case ":${PATH}:" in
#     *:"$HOME/.local/bin":*)
#         ;;
#     *)
#         export PATH="$HOME/.local/bin${PATH:+:${PATH}}"
#         ;;
# esac

