# .bashrc
#
#

# PATH
# Ensure user-installed binaries take precedence
export PATH="~/.local/bin:/usr/local/bin:/usr/local/sbin:$PATH"

# character set
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
#
if command -v pyenv 1>/dev/null 2>&1; then
  # eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
  source $(pyenv root)/completions/pyenv.bash
  eval "$(pyenv virtualenv-init -)"
  export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi
## end pyenv

# PYTHONSTARTUP
#export PYTHONSTARTUP="/Users/gonzo/.config/ptpythonstartup.py"

# gpip
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

alias pipup='pip freeze | grep -v '^\-e' | cut -d = -f 1 | xargs pip install -U'
alias pipup3='pip3 freeze | grep -v '^\-e' | cut -d = -f 1 | xargs pip3 install -U'

# homebrew python pip
# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

export JAVA_HOME=$(/usr/libexec/java_home)

# OS specific
if [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
  #textmate
  export EDITOR="/usr/local/bin/atom -w"
  # Typora
  alias typora="open -a typora"

  # Set architecture flags
  export ARCHFLAGS="-arch x86_64"

  # http://natelandau.com/my-mac-osx-bash_profile/
  export CLICOLOR=1
  export LSCOLORS=ExFxBxDxCxegedabagacad

elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  #
  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
      xterm-color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt

  force_color_prompt=yes

  if [ -n "$force_color_prompt" ]; then
      if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  	# We have color support; assume it's compliant with Ecma-48
  	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  	# a case would tend to support setf rather than setaf.)
  	color_prompt=yes
      else
  	color_prompt=
      fi
  fi

  if [ "$color_prompt" = yes ]; then
      PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
      PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
  fi
  unset color_prompt force_color_prompt

  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
      ;;
  *)
      ;;
  esac

  # enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      #alias dir='dir --color=auto'
      #alias vdir='vdir --color=auto'

      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

fi
# end OS specific

### LESS ###
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable syntax-highlighting in less.
# brew install source-highlight
# First, add these two lines to ~/.bashrc
if [ -f "/usr/local/bin/src-hilite-lesspipe.sh" ]; then
  export LESSOPEN="|/usr/local/bin/src-hilite-lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi

export LESS=" -R -X -F"
alias less='less -m -N -g -i -J --underline-special --SILENT'
alias more='less'
# https://unix.stackexchange.com/questions/185544/no-colored-output-in-less-for-the-ls-command
export CLICOLOR_FORCE=1

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
# some more ls aliases
#alias ll='ls -halF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#
# bash sensible defaults
# https://github.com/mrzool/bash-sensible
if [ -f ~/.config/sensible.bash ]; then
   source ~/.config/sensible.bash
fi
# end bash.sensible

# git-prompt
if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
  source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
# git-prompt

#
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# gpg-agent
# https://blog.chendry.org/2015/03/13/starting-gpg-agent-in-osx.html
# https://chive.ch/security/2016/04/06/gpg-on-os-x.html
# gpg-agent with pinentry-mac

if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
 export GPG_AGENT_INFO
else
 eval $( gpg-agent --daemon )
fi
# end gpg


# homebrew bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
fi

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/gonzo/bin/google-cloud-sdk/path.bash.inc' ]; then
#   . '/Users/gonzo/bin/google-cloud-sdk/path.bash.inc';
# fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/gonzo/bin/google-cloud-sdk/completion.bash.inc' ]; then
#   . '/Users/gonzo/bin/google-cloud-sdk/completion.bash.inc';
# fi

# pass https://www.passwordstore.org/
source /usr/local/etc/bash_completion.d/pass

#torsocks
export TORSOCKS_CONF_FILE=/Users/gonzo/.torsocks.conf

# byobu
# byobu prompt
export BYOBU_PREFIX=/usr/local
[ -r /Users/gonzo/.byobu/prompt ] && . /Users/gonzo/.byobu/prompt
#byobu-prompt#

# kitty bash completion
#source <(kitty + complete setup bash)
source /dev/stdin <<<"$(kitty + complete setup bash)"
