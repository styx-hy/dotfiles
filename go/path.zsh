# Add go to $PATH
# if [[ -d "$HOME/zion/go/bin" ]]; then
#      PATH="$HOME/zion/go/bin":$PATH
# fi
appendpath "$HOME/zion/go/bin"

# if [[ -d "$HOME/zion/letsgo" ]]; then
#     export GOPATH=$HOME/zion/letsgo
#     export PATH=$PATH:$GOPATH/bin
# fi
appendpath "$HOME/zion/letsgo/bin"
