# My dotfiles

my dotfiles

## Features

- [bash sensible](https://github.com/mrzool/bash-sensible) defaults
- [passwordstore](https://www.passwordstore.org/)
- [sexy bash prompt](https://github.com/twolfson/sexy-bash-prompt)
- less sensible defaults
- [pyenv](https://github.com/pyenv/pyenv) and python defaults
- Linux & OSX support
- [dircolors][1], lots of colors
- bash aliases

## Installation

I haven't made my mind on how to setup my dotfiles, one option is to create a
bare git repository, as explained [here](https://www.atlassian.com/git/tutorials/dotfiles).
Another option is to set up a normal repo and `stow` your dotfiles. As I can
not make my mind, I support both.

### Bare repository option

```shell
git clone --bare https://github.com/gnzsnz/dotfiles.git $HOME/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
config checkout # use -f to overwrite existing dotfiles

source .bash_profile # to load shell in dotfiles
```

### Stow option

This requires stow. Wich can be installed like this

```bash
# osx
brew install stow
# debian/ubuntu
sudo apt install stow
```

Now that we have all that we need

```bash
cd $HOME
git clone https://github.com/gnzsnz/dotfiles.git .dotfiles
cd .dotfiles
stow .

# if you get a warnign about overriding existing files
# you can do this under your responsibility
stow --adopt .
git diff # see if you need anythin
git reset --hard origin master # ignore local files
```

## Usage

With the bare repository option. You can manage the dotfiles like this

```bash
config remote -v  # list remote git repository
config status     # git status

config pull       # pull upstream changes
config checkout   # apply changes
```

For `stow`, you just use git in the `.dotfiles` directory

## Setting up dircolors

Support for the following `dircolors` schemes

- [Solarized](https://github.com/seebi/dircolors-solarized)
- [NordTheme](https://github.com/nordtheme/dircolors)
- [bliss](https://github.com/joshjon/bliss-dircolors)
- [dracula](https://github.com/dracula/dircolors)
- [one-dark](https://github.com/r3tex/one-dark/blob/master/dircolors)

To select your theme edit `.bashrc` and set `THEME` environment variable.

Valid values for `THEME`:

- nordtheme
- solarized-256dark
- solarized-ansi-light
- bliss
- dracula
- one-dark
- solarized-ansi-dark
- solarized-ansi-universal

The default value is `dark-one`

If you know any other color scheme, I would love to include it. Please let me
know by creating an issue.

## Inspiration

- [Manage dotfiles with git](https://www.atlassian.com/git/tutorials/dotfiles)
- [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [https://github.com/webpro/dotfiles](https://github.com/webpro/dotfiles)
- [https://bitbucket.org/durdn/cfg](https://bitbucket.org/durdn/cfg/src/master/)

[1]: https://www.gnu.org/software/coreutils/manual/html_node/dircolors-invocation.html
