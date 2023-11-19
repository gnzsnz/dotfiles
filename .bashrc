#!/usr/bin/env bash
###############################################################################
# ~/.bashrc
#
# gnzsnz dotfiles
#
#
###############################################################################
# shellcheck disable=SC1091

# PATH
# Ensure user-installed binaries take precedence
PATH="$HOME/.local/bin:$PATH"
export PATH

# character set
#if locale -a | grep -qi 'en_US.UTF-8'; then
#  export LC_ALL=en_US.UTF-8
#  export LANG=en_US.UTF-8
#  export LC_CTYPE=en_US.UTF-8
#else
#  export LC_ALL=C.UTF-8
#  export LC_CTYPE=C.UTF-8
#fi;

# Set architecture flags
ARCHFLAGS="-arch $(uname -m)"
export ARCHFLAGS

# OS specific
if [[ "$OSTYPE" == "darwin"* ]]; then

	# set locale for OSX
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8

	# OSX settings - mainly brwe.sh
	# homebrew
	[ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
	[ -f /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"

	# disable env hints
	[ "$(which brew)" ] && export HOMEBREW_NO_ENV_HINTS=1

	# homebrew bash_completion
	#if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
	#    source "$(brew --prefix)/etc/bash_completion"
	#fi

	[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

	# brew.sh coreutils
	if [ -d "$(brew --prefix)/coreutils/libexec/gnubin" ]; then
		PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
		export PATH
	fi

	# set editor
	[ "$(which code)" ] && EDITOR="$(which code) -w"
	export EDITOR

	# pass https://www.passwordstore.org/
	if [ -f "$(brew --prefix)/etc/bash_completion.d/pass" ]; then
		# shellcheck disable=SC1091
		source "$(brew --prefix)/etc/bash_completion.d/pass"
	fi

	# OSX multipass
	if [[ $(which multipass) ]]; then
		PATH="$PATH:$HOME/Library/Application Support/multipass/bin"
		export PATH
	fi

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
	# Linux settins

	# bash completion
	if ! shopt -oq posix; then
		if [ -f /usr/share/bash-completion/bash_completion ]; then
			source /usr/share/bash-completion/bash_completion
		elif [ -f /etc/bash_completion ]; then
			source /etc/bash_completion
		fi
	fi

	# pass https://www.passwordstore.org/
	if [ -f "/usr/share/bash-completion/completions/pass" ]; then
		source /usr/share/bash-completion/completions/pass
	fi

	#
	# Linux multipass
	if [[ $(which multipass) ]]; then
		PATH="$PATH:$HOME/snap/multipass/common/bin"
		export PATH
	fi
##
fi
# end OS specific

#
# gpg-agent
# once OS specific is done, so brew path is set
GPG_TTY=$(tty)
export GPG_TTY
unset SSH_AGENT_PID

if [ "$(which gpg-connect-agent)" ]; then
	gpg-connect-agent updatestartuptty /bye >/dev/null
fi
if [ "$(which gpgconf)" ] && [ -S "$(gpgconf --list-dirs agent-ssh-socket)" ]; then
	SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	export SSH_AUTH_SOCK
fi
# end gpg

# java
#[[ $(which java) ]] && export JAVA_HOME=$(/usr/libexec/java_home)

# python
# shellcheck disable=SC1090
if [ -f ~/.config/pythonrc ]; then
	source ~/.config/pythonrc
fi

export THEME='one-dark'
# less
# shellcheck disable=SC1090
if [ -f ~/.config/lessrc ]; then
	source ~/.config/lessrc
fi

# dircolors
# shellcheck disable=SC1090
if [ -f ~/.config/dircolors ]; then
	source ~/.config/dircolors
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# shellcheck disable=SC1090
if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

# bash sensible defaults
# https://github.com/mrzool/bash-sensible
# shellcheck disable=SC1090
if [ -f ~/.config/sensible.bash ]; then
	source ~/.config/sensible.bash
fi
# end bash.sensible

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/gonzo/bin/google-cloud-sdk/path.bash.inc' ]; then
#   . '/Users/gonzo/bin/google-cloud-sdk/path.bash.inc';
# fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/gonzo/bin/google-cloud-sdk/completion.bash.inc' ]; then
#   . '/Users/gonzo/bin/google-cloud-sdk/completion.bash.inc';
# fi

#torsocks
[ -f "$HOME"/.torsocks.conf ] && TORSOCKS_CONF_FILE="$HOME"/.torsocks.conf
export TORSOCKS_CONF_FILE

# kitty bash completion
#source <(kitty + complete setup bash)
if [[ $(which kitty) ]]; then
	source /dev/stdin <<<"$(kitty + complete setup bash)"
fi

# sexy bash prompt
# https://github.com/twolfson/sexy-bash-prompt
# shellcheck disable=SC1090
[ -f ~/.config/bash_prompt ] && source ~/.config/bash_prompt
# end sexy bash prompt
