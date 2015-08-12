# FIXME the PATH variable should use push method
# This forces initialization only at the top level, e.g. the shell that
# fires up tmux
[ $SHLVL -eq 1 ] && eval "$(perl -I${HOME}/.perl5/lib/perl5 -Mlocal::lib=${HOME}/.perl5)"

# FIXME why?!
pushpath "/home/styx/.perl5/bin"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PERL_LOCAL_LIB_ROOT}/lib
