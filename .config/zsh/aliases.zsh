if hash exa 2> /dev/null; then
  alias ls='exa'
  alias tree='exa --tree'
fi

if hash bat 2> /dev/null; then
  alias cat='bat'
fi

if hash nvim 2> /dev/null; then
  alias vim='nvim'
fi

## conf aliases
alias tedit='pushd ${HOME} && \
  nvim .tmux.conf .tmux_line.conf; \
  popd'
alias vedit='pushd ${XDG_CONFIG_HOME} && \
  vim vim/vimrc nvim/init.vim; \
  popd'
alias zedit='pushd "${ZDOTDIR}" && \
  vim -p ${HOME}/.zshenv .zshrc *.zsh; \
  popd'

# vim: ft=zsh :
