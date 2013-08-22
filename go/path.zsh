# Add go to $PATH
if [[ -d "$HOME/zion/go/bin" ]]; then
    export PATH="$HOME/zion/go/bin":$PATH
fi

if [[ -d "$HOME/zion/letsgo" ]]; then
    export GOPATH=$HOME/zion/letsgo
    export PATH=$PATH:$GOPATH/bin
fi
