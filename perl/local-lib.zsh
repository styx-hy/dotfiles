# FIXME the PATH variable should use push method
[ $SHLVL -eq 1 ] && eval "$(perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=~/.perl5)"
# FIXME why?!
pushpath "/home/styx/.perl5/bin"
