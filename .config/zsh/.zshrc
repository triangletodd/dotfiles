#!/usr/bin/env zsh
# INIT {{{
declare -A ZI
ZI[HOME_DIR]="${ZDOTDIR}/incoming"
ZI[BIN_DIR]="${ZI[HOME_DIR]}/bin"

if [[ ! -f "${ZI[BIN_DIR]}/zi.zsh" ]]; then
  mkdir -p "${ZI[HOME_DIR]}"
  git clone https://github.com/z-shell/zi "${ZI[BIN_DIR]}"
fi

source "${ZI[BIN_DIR]}/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
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

# Load starship theme
# starship
# export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
# export STARSHIP_CACHE=$XDG_CACHE_HOME/starship
zi ice lucid \
  from"gh-r" \
  as"command" \
  bpick"*.tar.gz" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" \
  src"init.zsh"
zi light starship/starship

# fzf
zi snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zi snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zi ice \
  as"program" \
  from"gh-r"
zi light junegunn/fzf-bin

# syntax highlight
zi light zsh-users/zsh-syntax-highlighting

# direnv
zi wait'!1' lucid \
  from"gh-r" \
  as"program" \
  mv"direnv* -> direnv" \
  pick"direnv" \
  atclone'./direnv hook zsh > zhook.zsh' \
  atpull'%atclone' \
  src'zhook.zsh' \
  light-mode for @direnv/direnv

#asdf
  zi wait'1' lucid \
  atinit"export \
    ASDF_CONFIG_FILE=$XDG_CONFIG_HOME/asdf/config \
    ASDF_DATA_DIR=~$XDG_CONFIG_HOME/asdf \
    ASDF_DIR=$ZI[HOME_DIR]/plugins/asdf-vm---asdf" \
  pick"asdf.sh" \
  light-mode for @asdf-vm/asdf

# delta
zi wait'1' lucid \
  from"gh-r" \
  as"program" \
  pick"delta*/delta" \
  light-mode for @dandavison/delta

# exa
zi wait'1' lucid \
  from"gh-r" \
  as"program" \
  pick"**/exa" \
  light-mode for @ogham/exa

# nvim
zi wait'1q' lucid \
  from"gh-r" \
  as"program" \
  light-mode for @neovim/neovim

  # ripgrep
zi wait'1' lucid blockf nocompletions \
  from"gh-r" \
  as'program' \
  pick'ripgrep*/rg' \
  atclone'chown -R $(id -nu):$(id -ng) .; zi creinstall -q BurntSushi/ripgrep' \
  atpull'%atclone' \
  light-mode for @BurntSushi/ripgrep

  # fd
zi wait'1' lucid blockf nocompletions \
  from"gh-r" \
  as'program' \
  cp"fd-*/autocomplete/_fd -> _fd" \
  pick'fd*/fd' \
  atclone'chown -R $(id -nu):$(id -ng) .; zi creinstall -q sharkdp/fd' \
  atpull'%atclone' \
  light-mode for @sharkdp/fd

# bat
zi wait'1' lucid \
  from"gh-r" \
  as"program" \
  cp"bat/autocomplete/bat.zsh -> _bat" \
  pick"bat*/bat" \
  atload"export BAT_THEME='gruvbox-dark'; alias cat=bat" \
  light-mode for @sharkdp/bat

# jq
zi wait'1' lucid \
  from"gh-r" \
  as"program" \
  mv"jq* -> jq" \
  pick"**/jq" \
  light-mode for @stedolan/jq

export EDITOR=nvim
export KEYTIMEOUT=1
export MANPAGER='nvim +Man!'
export MANWIDTH=999

FZF_COMPLETION_TRIGGER='~~'
FZF_COMPLETION_OPTS='+c -x'
FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FUNCTIONS {{{
fpath=( $ZDOTDIR/funcs "${fpath[@]}" )
autoload -U $fpath[1]/*(.:t)
# }}}

source $ZDOTDIR/aliases.zsh
if [[ -f $ZDOTDIR/$OSTYPE.zsh ]]; then
  source $ZDOTDIR/$OSTYPE.zsh
fi

# # ZI {{{
# local _zi_plugins=(
#    atclone"./install.sh" as"null"
#       @Homebrew/install
#    wait lucid src"fast-syntax-highlighting.plugin.zsh"
#       zdharma/fast-syntax-highlighting
#    wait lucid src"zsh-autosuggestions.zsh"
#       zsh-users/zsh-autosuggestions
#    wait lucid blockf atpull'zi creinstall -q src/'
#       zsh-users/zsh-completions
#    wait lucid load from"gh-r" id-as"gh-bin" sbin'*/bin/gh'
#       @cli/cli
#    wait lucid load from"gh-r" id-as"nvim-bin" sbin'nvim*/bin/nvim'
#       @neovim/neovim
# )
# zi for ${_zi_plugins#}
# #}}}



# COMPINIT {{{
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zi cdreplay -q
# }}}

if [[ -f $ZDOTDIR/private.zsh ]]; then
  source $ZDOTDIR/private.zsh
fi

# vim: ft=zsh :
