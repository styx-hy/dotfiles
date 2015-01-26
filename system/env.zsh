# Only set this if we haven't set $EDITOR up somewhere else previously.
if [[ "$EDITOR" == "" ]] ; then
  # Use sublime for my editor.
  export EDITOR='subl'
  # STYX Use emacs for my editor
  export EDITOR='emacsclient -n'
fi

# make `less' more friendly
LESSHISTFILE=/dev/null
