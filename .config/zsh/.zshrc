#!/usr/bin/env zsh
# INIT {{{
declare -A ZINIT
ZINIT[HOME_DIR]="${ZDOTDIR}/incoming"
ZINIT[BIN_DIR]="${ZINIT[HOME_DIR]}/bin"

if [[ ! -f "${ZINIT[BIN_DIR]}/zinit.zsh" ]]; then
  mkdir -p "${ZINIT[HOME_DIR]}"
  git clone https://github.com/zdharma/zinit.git "${ZINIT[BIN_DIR]}"
fi

source "${ZINIT[BIN_DIR]}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# }}}

# GLOBAL {{{
setopt autocd # change directories without typing cd
setopt pushdsilent # pushd and popd don't print dirs on run
setopt extended_glob # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns
setopt promptsubst # parameter expansion, command substitution and arithmetic expansion in prompts
setopt interactive_comments # allow comments even in interactive shells
setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

path=(
  "$HOME/bin"
  "/usr/local/bin"
  $path
)

export EDITOR=nvim
export KEYTIMEOUT=1
export PAGER=nvimpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

ASDF_DIR=$HOME/.asdf
FZF_COMPLETION_TRIGGER='**'
FZF_COMPLETION_OPTS='+c -x'
FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# }}}

# FUNCTIONS {{{
fpath=( $ZDOTDIR/funcs "${fpath[@]}" )
autoload -U $fpath[1]/*(.:t)
# }}}

# ZINIT {{{
local _zinit_plugins=(
   zinit-zsh/z-a-bin-gem-node
   load
      @asdf-vm/asdf
   load from"gh-r" atload'eval "$(starship init zsh)"' sbin'starship'
      starship/starship
   atclone"./install.sh" as"null"
      @Homebrew/install
   wait lucid atinit"zicompinit; zicdreplay"
      zdharma/fast-syntax-highlighting
   wait lucid
      zsh-users/zsh-autosuggestions
   wait lucid blockf atpull'zinit creinstall -q .'
      zsh-users/zsh-completions
   wait lucid load
      @agkozak/zsh-z
   wait lucid load from"gh-r" sbin'*/bin/gh'
      @cli/cli
   wait lucid load from"gh-r" sbin'nvim-osx64/bin/nvim'
      @neovim/neovim
   wait lucid load from"gh-r" sbin'fzf'
      @junegunn/fzf
   wait lucid load from"gh-r" sbin'*/bat'
      @sharkdp/bat
   wait lucid load from"gh-r" mv"exa*->exa" sbin'exa'
      ogham/exa
   wait lucid load from"gh-r" sbin'*/fd'
      @sharkdp/fd
)
zinit for ${_zinit_plugins#}
#}}}

# CUSTOM {{{
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/private.zsh
# }}}

# vim: ft=zsh :
