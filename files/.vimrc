let b:user_vimfiles="~/.vimrc"
map <F4> <Esc><LocalLeader>rf<Enter>
map <F5> <Esc>:wa<Enter><LocalLeader>ae<Enter>
nmap <F5> :wa<Enter><LocalLeader>ae<Enter>
vmap <buffer> <F5> <Esc>:call SendSelectionToR("echo", "down")<Enter>
