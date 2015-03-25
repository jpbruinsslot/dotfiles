"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pathogen
execute pathogen#infect()
filetype plugin indent on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" use vim settings, rather than vi settings
set nocompatible

" cursorline
set cursorline
hi CursorLine cterm=NONE ctermbg=8 ctermfg=NONE

" ignore when searching
set ignorecase

" when searching try to be smart about cases
set smartcase

" highlight search result
set hlsearch

" search as characters are entered
set incsearch

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" show line numbers
set number

" display status line at bottom of vim window
set ruler

"show command in bottom bar
set showcmd

" visual autocomplete for command menu
set wildmenu

" highlight matching [{()}]
set showmatch


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable syntax highlighting
syntax on

" use 256 colors
" set t_Co=256

" background color
set background=dark

" colorscheme
colorscheme molokai

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" make vim handle long lines nicely
set wrap
set textwidth=79
set formatoptions=qrn1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
let g:airline_theme = 'powerlineish'

" neocomplete settings
let g:neocomplete#enable_at_start_up = 1
