let s:path = expand('%:p')

setlocal cindent
setlocal cinoptions=:0,l1,t0,t0,(0
if s:path =~ 'dpdk'
	setlocal tabstop=8 shiftwidth=8 noexpandtab
elseif s:path =~ 'qemu'
	setlocal tabstop=4 shiftwidth=4 expandtab
else
	setlocal tabstop=4 shiftwidth=4 expandtab
endif
