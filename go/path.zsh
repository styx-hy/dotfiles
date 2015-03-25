# Add go to $PATH
# if [[ -d "$HOME/p/go/bin" ]]; then
#      PATH="$HOME/p/go/bin":$PATH
# fi
appendpath "$HOME/p/go/bin"

# if [[ -d "$HOME/p/letsgo" ]]; then
#     export GOPATH=$HOME/p/letsgo
#     export PATH=$PATH:$GOPATH/bin
# fi
export GOPATH="$HOME/p/iku"
appendpath "$GOPATH/bin"
