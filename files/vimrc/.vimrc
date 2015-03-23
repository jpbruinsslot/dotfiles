" pathogen
execute pathogen#infect()
syntax on
filetype plugin indent on

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
