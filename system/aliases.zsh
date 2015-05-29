# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if [ "$(uname -s)" = "Darwin" ]; then
    if $(gls &>/dev/null); then
	alias ls="gls -F --color"
	alias l="gls -lAh --color"
	alias ll="gls -l --color"
	alias la='gls -A --color'
    fi
else
    alias ls="ls -F --color"
    alias l="ls -lAh --color"
    alias ll="ls -l --color"
    alias la='ls -A --color'
fi

if $(lsll &>/dev/null)
then
  alias ls="lsll -F --color"
  alias l="lsll -lAh --color"
  alias ll="lsll -l --color"
  alias la='lsll -A --color'
fi

if $(nvim -v &>/dev/null); then
  alias vim="nvim"
fi

alias tmux="TERM=screen-256color tmux"
alias tat="tmux attach-session -t"
