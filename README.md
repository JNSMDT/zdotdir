# JNSMDTs ZDOTDIR

My small zsh config dir. To use create a `.zshenv` file inside your home directory.
After that add following snippit into it, so it uses your your own `.zshenv`.

```BASH
export JNSDMT_SERVERNAME=""

export ZDOTDIR=~/.config/zsh
[[ -f $ZDOTDIR/.zshenv ]] && . $ZDOTDIR/.zshenv
```
