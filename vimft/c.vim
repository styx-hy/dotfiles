let s:path = expand('%:p')

if s:path =~ 'dpdk'
	setlocal tabstop=8 shiftwidth=8 noexpandtab
" elseif l:path =~ 'examples'
	" setlocal tabstop=4 shiftwidth=4 expandtab
else
	setlocal tabstop=4 shiftwidth=4 expandtab
endif
