#!/usr/bin/env bash
###############################################################################
# ~/.bash_logout
#
# gnzsnz dotfiles
#
# ~/.bash_aliases: a collection of handy bash aliases.
#
###############################################################################

alias cp='cp -iv'             # Preferred 'cp' implementation
alias mv='mv -iv'             # Preferred 'mv' implementation
alias mkdir='mkdir -pv'       # Preferred 'mkdir' implementation
alias ln='ln -iv'             # Preferred 'ln' implementation
alias ls='ls -F --color=auto' # Preferred 'ls' implementation
alias sl='ls'                 # Preferred ls typo
alias ll='ls -FlAhp'
# some more ls aliases
alias la='ls -FAp'
alias l='ls -CF'
alias left='ls -Ftr -1' # sort by modification time

# cd
alias cd..='cd ..'

alias df='df -hT'
alias du='du -ch'
alias free='free -htw'

# grep ps
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem="ps aux | sort -nrk +4 | head | cat <(ps aux | head -1) - "
alias pscpu="ps aux | sort -nrk +3 | head | cat <(ps aux | head -1) - "

# grep history, ex gh grep
alias ghis='history|grep -i '

# grep env(viroment)
alias genv='env|grep -i '

# allow sudo
alias sudo='sudo '

# just what you need mount

# shellcheck disable=SC2142
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# dotfiles
# https://www.atlassian.com/git/tutorials/dotfiles
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
#

### add OS specific alias ###
case $(uname) in
Linux)
	# sort by size
	alias lt='ls --human-readable --size -1 -Sr --classify'
	alias crontab="crontab -i"
	alias dpkg-purge-list="dpkg --list | grep ^rc| cut -d ' ' -f 3"
	alias dpkg-purge='apt purge $(dpkg --list | grep ^rc| cut -d " " -f 3)'
	alias reboot-required='[ -f /var/run/reboot-required ] && echo "Reboot required" || echo "Reboot NOT required"'
	;;
Darwin)
	# sort by size
	alias lt='du -sh * | sort -hr'
	;;
esac
## end OS specific alias

# gpg update tty for pientry
alias gpgtty='gpg-connect-agent updatestartuptty /bye'

## fail2ban
alias f2bans='litecli -D /var/lib/fail2ban/fail2ban.sqlite3 -t -e "select jail, ip, datetime(a.timeofban, '\''unixepoch'\'') as timeofban, time(a.bantime, '\''unixepoch'\'') as bantime, a.bancount from bans a "'

alias f2bips='litecli -D /var/lib/fail2ban/fail2ban.sqlite3 -t -e "select a.jail, a.ip , datetime(a.timeofban, '\''unixepoch'\'') as timeofban, time(a.bantime, '\''unixepoch'\'' ) as bantime, a.bancount from bips a "'

# ls urls
lsurl() {
	curl -s "$1" | grep -o 'href=".*">' | sed -e "s/href=\"//g" | sed -e 's/">//g'
}

if [[ $(which python) && $(which pygmentize) ]]; then
	jsonpp() {
		if [ -z "$THEME" ]; then
			_style=one-dark
		else
			_style=$THEME
		fi
		python -m json.tool "$1" | pygmentize -l json -O style="$_style" | less
	}
fi

# exchange calendars
if [[ $(which ecal) ]]; then
	alias xcal='ecal XNYS $(date +"%m %Y")'
	alias ycal='ecal XNYS $(date +"%Y")'
fi
# end exchange calendars

# disable alias for current session
# unalias ll
#
# disable all aliases for current session
# unalias -a
#
# candidates for an alias - history top 10
# history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
