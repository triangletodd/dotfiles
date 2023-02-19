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

alias ls='ls --color'

asdf-bootstrap() {
  for i in $(cat ~/.tool-versions | cut -d ' ' -f 1); do 
    asdf plugin add $i; 
  done
}

## conf aliases
alias tedit='pushd ${HOME} && \
  vim -p .tmux.conf .tmux_line.conf; \
  popd'
alias vedit='pushd ${XDG_CONFIG_HOME} && \
  vim -p nvim/init.vim vim/vimrc; \
  popd'
alias zedit='pushd "${ZDOTDIR}" && \
  vim -p ${HOME}/.zshenv .zshrc *.zsh; \
  popd'

# vim: ft=zsh :
