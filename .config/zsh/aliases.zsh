_cmdexists() { hash "$@" 2> /dev/null }
if _cmdexists exa; then
  alias ls='exa'
fi

if _cmdexists bat; then
  alias cat='bat'
fi

if _cmdexists nvim; then
  alias vim='nvim'
fi

_ppath() { perl -pe 's/:/\n/g' <<<  $PATH }

## conf aliases
alias tedit='pushd ${HOME} && \
  nvim .tmux.conf .tmux_line.conf; \
  popd'
alias vedit='pushd ${XDG_CONFIG_HOME} && \
  vim vim/vimrc nvim/init.vim; \
  popd'
alias zedit='pushd "${ZDOTDIR}" && \
  vim -p ${HOME}/.zshenv .zshrc *.zsh \
  dirs'

# vim: ft=zsh :
