"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"   erroneousboat
"   jpbruinsslot@gmail.com
"
" Sections:
"   -> General
"   -> Plug-ins
"   -> VIM user interface
"   -> Colors and Fonts
"   -> Files, backups and undo
"   -> Text, tab and indent related
"   -> Key mapping
"   -> Plugin settings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set how many lines of history VIM has to remember
set history=700

" enable filetype plugins
filetype plugin on
filetype indent on

" set auto read when a files is changed from the outside
set autoread


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins 
" :PlugInstall
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/erroneousboat/molokai.git'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/Shougo/neocomplete.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/myusuf3/numbers.vim.git'
Plug 'https://github.com/Lokaltog/vim-easymotion.git'
Plug 'https://github.com/klen/python-mode.git'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/leshill/vim-json.git'
Plug 'https://github.com/ekalinin/Dockerfile.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/kchmck/vim-coffee-script'
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'https://github.com/Matt-Deacalion/vim-systemd-syntax'
Plug 'https://github.com/mxw/vim-jsx.git'
Plug 'https://github.com/chriskempson/base16-vim/'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/valloric/MatchTagAlways'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/scrooloose/syntastic'
Plug 'https://github.com/xolox/vim-easytags'
Plug 'https://github.com/xolox/vim-misc'

call plug#end()


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

" line seperator character
set fillchars+=vert:│

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
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

"show command in bottom bar
set showcmd

" visual autocomplete for command menu
set wildmenu

" highlight matching [{()}]
set showmatch

" redraw only when we need to
set lazyredraw

" disable background erase, background color will work in tmux
set t_ut=

" remove default vim mode information
set noshowmode

" ignore compiled files
set wildignore=*.o,*~,*.pyc

" return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" enable all python syntax highlighting features
let python_highlight_all = 1

" highlight column limit
set colorcolumn=79

" highlight only when exceeding column limit
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%79v', 100)

" Show syntax highlighting groups for word under cursor
nmap <leader>p :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


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

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" set italics
highlight Comment gui=italic
set t_ZH=^[[3m
set t_ZR=^[[23m

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git anyway
set nobackup
set nowb
set noswapfile


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
set textwidth=79
set formatoptions=qrn1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Quickly resize windows with a vertical split
map - <C-W>-
map + <C-W>+

" Useful mappings for managing tabs
nnoremap tn :tabnew<cr>
nnoremap to :tabonly<cr>
nnoremap tc :tabclose<cr>
nnoremap tm :tabmove<Space>

" Tab navigation
nnoremap th :tabprev<CR>
nnoremap tl :tabnext<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" save session, reopen it with vim -S
nnoremap <leader>s :mksession!<cr>

" ctrl+s should save (only works in gui)
nmap <C-s>s :w<CR>
vmap <C-s> <Esc><C-s>gv
nmap <C-s> <Esc><C-s>

" Wrapped lines goes down/up to next row, rather than next
" line in file.
noremap j gj
noremap k gk

" Remove highlight from search when not needed
nmap <leader>q :nohlsearch<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree settings
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', 'none')
call NERDTreeHighlightFile('ini', 'yellow', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('yml', 'yellow', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('config', 'yellow', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('json', 'green', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('html', 'yellow', 'none', '#d8a235', 'none')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', 'none')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', 'none')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', 'none')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', 'none')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', 'none')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', 'none')
call NERDTreeHighlightFile('gitconfig', 'black', 'none', '#686868', 'none')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#7F7F7F', 'none')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', 'none')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', 'none')

call NERDTreeHighlightFile('py', 'blue', 'none', '#376F9D', 'none')
call NERDTreeHighlightFile('md', 'blue', 'none', '#679EB5', 'none')
call NERDTreeHighlightFile('sh', 'blue', 'none', '#AB74A0', 'none')
call NERDTreeHighlightFile('go', 'blue', 'none', '#6AD7E5', 'none')
call NERDTreeHighlightFile('html', 'red', 'none', '#6AD7E5', 'none')

" pymode
let g:pymode_folding=0
let g:pymode_lint_cwindow=0
set completeopt-=preview

" vim-go: enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"

" vim-go: syntax highlighting for functions, methods and structs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" lightline.vim settings
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'readonly': 'MyReadonly',
    \   'modified': 'MyModified',
    \   'filename': 'MyFilename'
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

function! MyModified()
    if &filetype == "help"
        return ""
    elseif &modified
        return "+"
    elseif &modifiable
        return ""
    else
        return ""
    endif
endfunction

function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return "❌"
    else
        return ""
    endif
endfunction

function! MyFugitive()
    if exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? '⎇  '._ : ''
    endif
    return ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

" neocomplete settings
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_start_up = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" tagbar golang settings
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" tmux settings: allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" easymotion
let g:EasyMotion_leader_key = '<leader><leader>'

" startify, used figlet -f slant erroneousboat for ascii text
let g:startify_list_order = ['bookmarks', 'files', 'sessions']
let g:startify_bookmarks = [
    \ '~/Projects',
    \ ]
let g:startify_custom_header = [
    \ '                                                      __                __ ',
    \ '    ___  ______________  ____  ___  ____  __  _______/ /_  ____  ____ _/ /_',
    \ '   / _ \/ ___/ ___/ __ \/ __ \/ _ \/ __ \/ / / / ___/ __ \/ __ \/ __ `/ __/',
    \ '  /  __/ /  / /  / /_/ / / / /  __/ /_/ / /_/ (__  ) /_/ / /_/ / /_/ / /_  ',
    \ '  \___/_/  /_/   \____/_/ /_/\___/\____/\__,_/____/_.___/\____/\__,_/\__/  ',
    \ '',
    \ '  =========================================================================',
    \ '',
    \ ]

" indent line
let g:indentLine_char = '│'

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
