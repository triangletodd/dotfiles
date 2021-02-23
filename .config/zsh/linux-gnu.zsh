alias pbcopy="xsel -ib"

LIBREW="~linuxbrew/.linuxbrew/bin/brew"

if [[ -f "${LIBREW}" ]]; then
  eval $("${LIBREW}" shellenv)
fi
