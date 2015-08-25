" Vundle: https://github.com/VundleVim/Vundle.vim
" --------------------------------------------------------------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'chrisbra/csv.vim'
Plugin 'scrooloose/syntastic'
Plugin 'davidhalter/jedi-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'itchyny/landscape.vim'
Plugin 'python-rope/ropevim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
call vundle#end()
filetype plugin indent on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" see :h vundle for more details or wiki for FAQ
" ----------------------------------------------------------------------------

" Pathogen
execute pathogen#infect()

" Jedi-Vim
let g:jedi#auto_initialization = 1

" Search Options
set hlsearch
set incsearch
set ignorecase

" Indentation Options
set expandtab
set tabstop=4
retab
set shiftwidth=4

nmap <Space> i_<Esc>r
filetype plugin indent on
syntax on
colo delek

" Rope Vim (for Python)
let ropevim_vim_completion=1
let ropevim_extended_complete=1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Color Theme
colorscheme torte

" LightLine
set encoding=utf-8
scriptencoding utf-8
let g:lightline = {
      \ 'colorscheme': 'landscape',
      \ }
set laststatus=2
