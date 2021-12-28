# .bash_profile
# Load .bashrc and .profile if they exists

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ -f ~/.profile ]; then
   source ~/.profile
fi
