# export PATH="./bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$HOME/.sfs:$ZSH/bin:$PATH"
pushpath "./bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$HOME/.sfs:$ZSH/bin"
appendpath "$HOME/zion/projects/ssearcher"
appendpath "$HOME/zion/racket/racket/bin"

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

if [[ -d "$HOME/.pb" ]]; then
    export PERLBREW_ROOT=~/.pb
    source ~/.pb/etc/bashrc
fi
