" pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

" use vim settings, rather than vi settings
set nocompatible

" for 256 colors on the terminal
set t_Co=256

" cursorline
set cursorline
hi CursorLine cterm=NONE ctermbg=8 ctermfg=NONE

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" key mapping
map <C-n> :NERDTreeToggle<CR>		" NERDtree

" make vim handle long lines nicely
set wrap
set textwidth=79
set formatoptions=qrn1
set number

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" vim-airline settings
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'molokai'
