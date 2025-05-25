#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#
echo "Loading ZDOTDIR/.zshrc"
# Zsh options.
setopt extended_glob

# Config MagicEnter
MAGIC_ENTER_OTHER_COMMAND='ll'

# Completion
# Source zstyles you might use with antidote.
[[ -e ${ZDOTDIR:-~}/.zstyles ]] && source ${ZDOTDIR:-~}/.zstyles

# Clone antidote if necessary.
[[ -d ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-~}/.antidote
#
# Load antidote and plugins.
#
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

#
# load DIRENV
#
eval "$(direnv hook zsh)"

#
# load zoxide
#
eval "$(zoxide init zsh)"

#
# load cargo
#
. "$HOME/.cargo/env"

#
# load fnm
#
eval "$(fnm env --use-on-cd)"

#
# load Starship at last
#
eval "$(starship init zsh)"