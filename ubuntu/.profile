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
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/.local/bin" ] ; then
#     PATH="$HOME/.local/bin:$PATH"
# fi
case ":${PATH}:" in
*:"$HOME/.local/bin":*) ;;
*)
	export PATH="$HOME/.local/bin${PATH:+:${PATH}}"
	;;
esac
case ":${PATH}:" in
*:"$HOME/.local/go/bin":*) ;;
*)
	export PATH="$HOME/.local/go/bin${PATH:+:${PATH}}"
	;;
esac
case ":${PATH}:" in
*:"$HOME/.local/zig":*) ;;
*)
	export PATH="$HOME/.local/zig${PATH:+:${PATH}}"
	;;
esac
case ":${PATH}:" in
*:"/usr/local/cuda/bin":*) ;;
*)
	export PATH="/usr/local/cuda/bin${PATH:+:${PATH}}"
	;;
esac
case ":${PATH}:" in
*:"$HOME/.modular/pkg/packages.modular.com_mojo/bin":*) ;;
*)
	export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin${PATH:+:${PATH}}"
	;;
esac

case ":${PATH}:" in
*:"$HOME/.cargo/bin":*) ;;
*)
	export PATH="$HOME/.cargo/bin${PATH:+:${PATH}}"
	;;
esac

case ":${PATH}:" in
*:"$HOME/gems/bin":*) ;;
*)
	export PATH="$HOME/gems/bin${PATH:+:${PATH}}"
	;;
esac

case ":${PATH}:" in
*:"$HOME/.rbenv/bin":*) ;;
*)
	export PATH="$HOME/.rbenv/bin${PATH:+:${PATH}}"
	;;
esac

case ":${PATH}:" in
*:"$(modular config max.path)/bin":*) ;;
*)
	export PATH="$(modular config max.path)/bin${PATH:+:${PATH}}"
	;;
esac

export MODULAR_HOME="$HOME/.modular"
export GEM_HOME="$HOME/gems"
if command -v rbenv >/dev/null; then
	eval "$(rbenv init -)"
fi
. "$HOME/.cargo/env"
