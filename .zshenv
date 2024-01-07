#!/bin/zsh
##? .zshenv - Zsh environment file, loaded always.

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

# Use .zprofile for remaining environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi


export PAGER="${PAGER:-less}"

#
# GOLANG
#

GOLANG_PATH="$HOME/.gobrew/current/bin:$HOME/.gobrew/bin"
export GOROOT="$HOME/.gobrew/current/go"
export GO111MODULE="on"

#
# PYTHON
#
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#
# BUN
#
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


#
# TEXLIVE
#

TEXLIVE_PATH="/usr/local/texlive/2023/bin/x86_64-linux"

#
# GIT (HOST)
#

export HOST_GITLAB_SSH="ssh://git@gitlab.hochschule-stralsund.de:2224"
export HOST_GITLAB_HTTPS="https://gitlab.hochschule-stralsund.de"

#
# PNPM
#

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


#
# Other Env Variables
#
export TAMPLATE_DIR="$HOME/dev/templates"

#
# Keybindings
#

### ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# urxvt
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word

### ctrl+delete
bindkey "\e[3;5~" kill-word
# urxvt
bindkey "\e[3^" kill-word

### ctrl+backspace
bindkey '^H' backward-kill-word

#
#  Paths
#
# WSL options
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  export WIN_ROOT="/mnt/c"
  export WIN_HOME="$(wslpath "$(wslvar USERPROFILE)")"

  WINDOWS_PATHS=(
    "$WIN_HOME/AppData/Local/Microsoft/WindowsApps" # Windows Store Apps
    "$WIN_HOME/AppData/Local/Programs/Microsoft VS Code/bin" # VS Code
    "$WIN_ROOT/Program Files/Docker/Docker/resources/bin" # Docker
    "$WIN_ROOT/ProgramData/DockerDesktop/version-bin" # Docker
    "$WIN_ROOT/Program Files (x86)/gnupg/bin" # GPG
    "$WIN_ROOT/Program Files/PowerShell/7" # PowerShell
		"$WIN_ROOT/Program Files/Google/Chrome Beta/Application" # Chrome Beta
    "$WIN_ROOT/Windows"
  )
fi
# Ensure path arrays do not contain duplicates.
typeset -gU path fpath

# Set the list of directories that zsh searches for commands.
path=(
  $HOME/{,s}bin(N)
  /opt/local/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $HOME/.local/bin
  $HOME/.cargo/bin
  $VOLTA_HOME/bin
  $GOLANG_PATH
  $TEXLIVE_PATH
  $WINDOWS_PATHS
  $path
)
