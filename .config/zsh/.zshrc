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
setopt autocd                   # Change directories without typing cd
setopt pushdsilent              # pushd and popd don't print dirs on run
setopt extended_glob            # Treat the ‘#’, ‘~’ and ‘^’ characters as part of patterns
setopt promptsubst              # Parameter expansion, command substitution and arithmetic expansion in prompts
setopt interactive_comments     # Allow comments even in interactive shells
setopt auto_list                # Automatically list choices on ambiguous completion
setopt auto_menu                # Automatically use menu completion
setopt always_to_end            # Move cursor to end if word had one match

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt bang_hist                 # Treat the '!' character specially during expansion.
setopt extended_history          # Write the history file in the ":start:elapsed;command" format.
setopt inc_append_history        # Write to the history file immediately, not when the shell exits.
setopt share_history             # Share history between all sessions.
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming history.
setopt hist_ignore_dups          # Don't record an entry that was just recorded again.
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a duplicate.
setopt hist_find_no_dups         # Do not display a line previously found.
setopt hist_ignore_space         # Don't record an entry starting with a space.
setopt hist_save_no_dups         # Don't write duplicate entries in the history file.
setopt hist_reduce_blanks        # Remove superfluous blanks before recording entry.
setopt hist_verify               # Don't execute immediately upon history expansion.
setopt hist_beep                 # Beep when accessing nonexistent history.

path=(
  "$HOME/bin"
  "/usr/local/bin"
  $path
)

export EDITOR=nvim
export KEYTIMEOUT=1
export PAGER=nvimpager
export MANPAGER='nvim +Man!'
export MANWIDTH=999

ASDF_DIR=$HOME/.asdf
FZF_COMPLETION_TRIGGER='~~'
FZF_COMPLETION_OPTS='+c -x'
FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# }}}

# FUNCTIONS {{{
fpath=( $ZDOTDIR/funcs "${fpath[@]}" )
autoload -U $fpath[1]/*(.:t)
# }}}

source $ZDOTDIR/aliases.zsh
if [[ -f $ZDOTDIR/$OSTYPE.zsh ]]; then
  source $ZDOTDIR/$OSTYPE.zsh
fi

# ZINIT {{{
local _zinit_plugins=(
   zinit-zsh/z-a-bin-gem-node
   load
      @asdf-vm/asdf
   load from"gh-r" atload'eval "$(starship init zsh)"' sbin'starship'
      starship/starship
   atclone"./install.sh" as"null"
      @Homebrew/install
   wait lucid src"fast-syntax-highlighting.plugin.zsh"
      zdharma/fast-syntax-highlighting
   wait lucid load
      @agkozak/zsh-z
   wait lucid multisrc"shell/{completion,key-bindings}.zsh"
      junegunn/fzf
   wait lucid src"zsh-autosuggestions.zsh"
      zsh-users/zsh-autosuggestions
   wait lucid blockf atpull'zinit creinstall -q src/'
      zsh-users/zsh-completions
   wait lucid load from"gh-r" id-as"gh-bin" sbin'*/bin/gh'
      @cli/cli
   wait lucid load from"gh-r" id-as"nvim-bin" sbin'nvim*/bin/nvim'
      @neovim/neovim
   wait lucid load from"gh-r" id-as"fzf-bin" sbin'fzf'
      @junegunn/fzf
   wait lucid load from"gh-r" id-as"bat-bin" sbin'*/bat'
      @sharkdp/bat
   wait lucid load from"gh-r" id-as"exa-bin" mv"exa*->exa" sbin'exa'
      ogham/exa
   #wait lucid load blockf from"gh-r" id-as"fd-bin" sbin'*/fd'
   #   @sharkdp/fd
)
zinit for ${_zinit_plugins#}
#}}}

# COMPINIT {{{
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zinit cdreplay -q
# }}}

if [[ -f $ZDOTDIR/private.zsh ]]; then
  source $ZDOTDIR/private.zsh
fi

# vim: ft=zsh :
