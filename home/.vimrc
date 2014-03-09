execute pathogen#infect()

set number
:highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE

set hls

syntax enable

" This was here for solarized, but I'm not using that now...
set t_Co=256
set background=dark
" let solarized_termtrans=1
" colorscheme solarized

filetype plugin indent on

" Indent by 2 spaces (no tabs)
" Use :set noet to turn this off
set tabstop=2
set shiftwidth=2
set expandtab

" Indent the next line the same as the previous line
set smartindent

" When you're typing your way through a command, show you what you've typed so
" far
set showcmd

