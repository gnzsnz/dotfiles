#!/usr/bin/env bash
###############################################################################
# ~/.bashrc
#
# gnzsnz dotfiles
#
# Load .bashrc and .profile if they exists
#
###############################################################################

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

# if you enable it make sure that .profile is not calling bashrc
#if [ -f ~/.profile ]; then
#   source ~/.profile
#fi

###############################################################################
#
#####    From bash man page
#
# When bash is invoked as an interactive login shell, or as a non-interactive 
# shell with the --login option, it first reads and executes commands from the 
# file /etc/profile, if  that  file  exists.   After  reading  that  file, it 
# looks for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and 
# reads and executes commands from the first one that exists and is readable. The
# --noprofile option may be used when the shell is started to inhibit this 
# behavior.
#
# When an interactive login shell exits, or a non-interactive login shell 
# executes the exit builtin command, bash reads and executes commands from the 
# file ~/.bash_logout, if it exists.
#
# When an interactive shell that is not a login shell is started, bash reads and 
# executes commands from /etc/bash.bashrc and ~/.bashrc, if these files exist.  
# This may be inhibited by using the --norc option.  The --rcfile file option 
# will force bash to read and execute commands from file instead of 
# /etc/bash.bashrc and ~/.bashrc.
#
# If bash is invoked with the name sh, it tries to mimic the startup behavior of 
# historical versions of sh as closely as possible, while conforming to the POSIX 
# standard as well.  When  invoked as  an  interactive login shell, or a 
# non-interactive shell with the --login option, it first attempts to read and 
# execute commands from /etc/profile and ~/.profile, in that order.
#
# Bash  attempts to determine when it is being run with its standard input 
# connected to a network connection, as when executed by the remote shell daemon,
# usually rshd, or the secure shell daemon sshd.  If bash determines it is being 
# run in this fashion, it reads and executes commands from ~/.bashrc and 
# ~/.bashrc, if these files exist and are readable.
#
###############################################################################
