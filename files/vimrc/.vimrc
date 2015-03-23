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
