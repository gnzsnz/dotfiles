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
export PATH="$HOME/.local/bin:$PATH"

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
export ARCHFLAGS="-arch $(uname -m)"

#
# gpg-agent
GPG_TTY=$(tty)
export GPG_TTY
unset SSH_AGENT_PID

if [ "$(which gpg-connect-agent)" ]; then
  gpg-connect-agent updatestartuptty /bye >/dev/null
fi
if [ "$(which gpgconf)" ] && [ -S "$(gpgconf --list-dirs agent-ssh-socket)" ]
then
  SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export SSH_AUTH_SOCK
elif [ "$(which gpgconf)" ] && [ ! -S "$(gpgconf --list-dirs agent-ssh-socket)" ]
then
  eval "$(gpg-connect-agent /bye)"
  SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  export SSH_AUTH_SOCK
fi
# end gpg

# OS specific
if [[ "$OSTYPE" == "darwin"* ]]; then 
  # OSX settings - mainly brwe.sh
  # homebrew
  [ -f /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"
  [ -f /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"

  # homebrew bash_completion
  #if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
  #    source "$(brew --prefix)/etc/bash_completion"
  #fi

  [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

  # brew.sh coreutils
  if [ -d "$(brew --prefix)/coreutils/libexec/gnubin" ]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  fi

  # set editor
  [ "$(which code)" ] && export EDITOR="$(which code) -w"
  
  # pass https://www.passwordstore.org/
  if [ -f "$(brew --prefix)/etc/bash_completion.d/pass" ]; then
    # shellcheck disable=SC1091
    source "$(brew --prefix)/etc/bash_completion.d/pass";
  fi

  # OSX multipass
  if [[ $(which multipass) ]]; then
    export PATH="$PATH:$HOME/Library/Application Support/multipass/bin"
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
    source /usr/share/bash-completion/completions/pass;
  fi

  #
  # Linux multipass
  if [[ $(which multipass) ]]; then
    export PATH="$PATH:$HOME/snap/multipass/common/bin"
  fi
##
fi
# end OS specific

# java
#[[ $(which java) ]] && export JAVA_HOME=$(/usr/libexec/java_home)

# python
if [ -f ~/.config/pythonrc ]; then
    source ~/.config/pythonrc
fi

export THEME='one-dark'
# less
if [ -f ~/.config/lessrc ]; then
    source ~/.config/lessrc
fi

# dircolors
if [ -f ~/.config/dircolors ]; then
    source ~/.config/dircolors
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# bash sensible defaults
# https://github.com/mrzool/bash-sensible
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
[ -f "$HOME"/.torsocks.conf ] && export TORSOCKS_CONF_FILE="$HOME"/.torsocks.conf

# byobu https://manpages.ubuntu.com/manpages/focal/en/man1/byobu.1.html
# export BYOBU_PREFIX=/usr/local
# BYOBU_CONFIG_DIR=$XDG_CONFIG_HOME/byobu
# $BYOBU_CONFIG_DIR/statusrc
# $BYOBU_CONFIG_DIR/datetime
# $BYOBU_CONFIG_DIR/windows.tmux
# byobu prompt
#[ -r $HOME/.byobu/prompt ] && . $HOME/.byobu/prompt
#byobu-prompt#

# kitty bash completion
#source <(kitty + complete setup bash)
if [[ $(which kitty) ]]; then
  source /dev/stdin <<<"$(kitty + complete setup bash)";
fi

# sexy bash prompt
# https://github.com/twolfson/sexy-bash-prompt
[ -f ~/.config/bash_prompt ] && source ~/.config/bash_prompt
# end sexy bash prompt
