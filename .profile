# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$HOME/.local/bin:$PATH"
# fi
case ":${PATH}:" in
    *:"$HOME/.local/bin":*)
        ;;
    *)
        export PATH="$HOME/.local/bin${PATH:+:${PATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"$HOME/.local/go/bin":*)
        ;;
    *)
        export PATH="$HOME/.local/go/bin${PATH:+:${PATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"$HOME/.local/zig":*)
        ;;
    *)
        export PATH="$HOME/.local/zig${PATH:+:${PATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"/usr/local/cuda-12.2/bin":*)
        ;;
    *)
        export PATH="/usr/local/cuda-12.2/bin${PATH:+:${PATH}}"
        ;;
esac
case ":${PATH}:" in
    *:"/home/support/.modular/pkg/packages.modular.com_mojo/bin":*)
        ;;
    *)
        export PATH="/home/support/.modular/pkg/packages.modular.com_mojo/bin${PATH:+:${PATH}}"
        ;;
esac

case ":${PATH}:" in
    *:"$HOME/.cargo/bin":*)
        ;;
    *)
        export PATH="$HOME/.cargo/bin${PATH:+:${PATH}}"
        ;;
esac

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export MODULAR_HOME="/home/support/.modular"
