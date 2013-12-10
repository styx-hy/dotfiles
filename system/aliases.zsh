# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if [ "$(uname -s)" = "Darwin" ]; then
  alias lsll="gls"
else
  alias lsll="ls"
fi

if $(lsll &>/dev/null)
then
  alias ls="lsll -F --color"
  alias l="lsll -lAh --color"
  alias ll="lsll -l --color"
  alias la='lsll -A --color'
fi

alias tat="tmux attach-session -t"
