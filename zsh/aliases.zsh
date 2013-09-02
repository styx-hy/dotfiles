alias reload!='. ~/.zshrc'

# set up fasd
if hash fasd 2>/dev/null; then
    eval "$(fasd --init auto)"
    unalias sf
fi
