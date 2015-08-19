execute pathogen#infect()
let g:jedi#auto_initialization = 1
set hlsearch
set incsearch
set ignorecase
set expandtab
set tabstop=4
retab
set shiftwidth=4
nmap <Space> i_<Esc>r
filetype plugin indent on
syntax on
colo delek
let ropevim_vim_completion=1
let ropevim_extended_complete=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
colorscheme torte
