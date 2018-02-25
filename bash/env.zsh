if [ -z "$(uname -r | grep -q Microsoft)" ]; then
    export BASH_ENV="~/.bashrc_ni"
fi
