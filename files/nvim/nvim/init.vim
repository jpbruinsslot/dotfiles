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
"
" To get a specific branch:
" Plug 'https://github.com/erroneousboat/molokai.git', {'branch': 'dev'}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" Interface
Plug 'https://github.com/erroneousboat/molokai.git'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://github.com/myusuf3/numbers.vim.git'
Plug 'https://github.com/mhinz/vim-startify.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'

" Productivity
Plug 'https://github.com/tomtom/tcomment_vim'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/Raimondi/delimitMate'
Plug 'https://github.com/valloric/MatchTagAlways'
Plug 'https://github.com/benekastah/neomake.git'
Plug 'https://github.com/Shougo/deoplete.nvim'

" Programming languages specific plugins
Plug 'https://github.com/fatih/vim-go.git'
Plug 'https://github.com/erroneousboat/python-mode.git'
Plug 'https://github.com/crosbymichael/vim-cfmt.git'
Plug 'https://github.com/zchee/deoplete-go.git', {'do': 'make'}

" Filetype plugins
Plug 'https://github.com/ekalinin/Dockerfile.vim.git'
Plug 'https://github.com/mxw/vim-jsx.git'
Plug 'https://github.com/leshill/vim-json.git'

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

" disable cursor styling
set guicursor=

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

" enable folding
set foldenable

" open most folds by default
set foldlevelstart=10

" 10 nested fold max
set foldnestmax=10

" fold based on indent level
set foldmethod=indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install font from https://github.com/ryanoasis/nerd-fonts
" a patched version of Hack called Knack, this will work with
" devicons. And set the font in the terminal preferences.

" enable syntax highlighting
syntax on

" background color
set background=dark

" colorscheme
colorscheme molokai

" neovim true color now requires
set termguicolors

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

" Leader is comma
let mapleader=","

" Comment lines with ctrl+/
map <C-/> :TComment<cr>
vmap <C-/> :TComment<cr>gv

" Indent lines with ctrl+[ and ctrl+]
" Commented out, produces weird behaviour.
" Normal mode, ESC will undo indent.
" Visual mode, can't get back to normal mode
" nmap <C-]> >>
" nmap <C-[> <<
" vmap <C-[> <gv
" vmap <C-]> >gv

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Center when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Do not show q: window
map q: :q

" Use 'j' and 'k' for scrolling in complete menu
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree settings
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.vim$', '\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=0
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('ini', 'yellow', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('yml', 'yellow', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('conf', 'yellow', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('json', 'green', 'none', '#d8a235', 'none')
call NERDTreeHighlightFile('js', 'yellow', 'none', '#F8DC3D', 'none')
call NERDTreeHighlightFile('py', 'blue', 'none', '#376F9D', 'none')
call NERDTreeHighlightFile('md', 'blue', 'none', '#679EB5', 'none')
call NERDTreeHighlightFile('sh', 'blue', 'none', '#AB74A0', 'none')
call NERDTreeHighlightFile('go', 'blue', 'none', '#6AD7E5', 'none')
call NERDTreeHighlightFile('html', 'red', 'none', '#E44D26', 'none')
call NERDTreeHighlightFile('jsx', 'cyan', 'none', '#00d8ff', 'none')
call NERDTreeHighlightFile('css', 'blue', 'none', '#1C70B0', 'none')
call NERDTreeHighlightFile('scss', 'cyan', 'none', '#C6538C', 'none')

" Set colors
hi NERDTreeDir          guifg=#F9F9F8
hi NERDTreeOpenable     guifg=#7E8E91
hi NERDTreeClosable     guifg=#7E8E91
hi NERDTreeDirSlash     guifg=#7E8E91
hi NERDTreeCWD          guifg=#7E8E91

" Replace folder arrow indicator
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" pymode
let g:pymode_rope_complete_on_dot = 0
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

" Will add `+` next to file name when file has changed
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

" Will show ... when file is Read Only
function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return ""
    else
        return ""
    endif
endfunction

" Will make use of plugin Fugitive to show branch and `⎇` icon
function! MyFugitive()
    if exists("*fugitive#head")
        let _ = fugitive#head()
        return strlen(_) ? ' '._ : ''
    endif
    return ''
endfunction

function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

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

" startify, used figlet -f slant erroneousboat for ascii text
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0
let g:startify_list_order = ['sessions', 'bookmarks', 'files']
let g:startify_bookmarks = [
    \ '~/Projects',
    \ ]
let g:startify_custom_header = [
     \ '      ____       __ __        __________  ',
     \ '     / __ \_  __/ // / ____ _/ ____/ __ \ ',
     \ '    / / / / |/_/ // /_/ __ `/___ \/ / / / ',
     \ '   / /_/ />  </__  __/ /_/ /___/ / /_/ /  ',
     \ '   \____/_/|_|  /_/  \__,_/_____/\____/   ',
    \ '',
    \ '   ======================================',
    \ '',
    \ ]

hi StartifyBracket  guifg=#585858 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyFile     guifg=#eeeeee ctermfg=255 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyFooter   guifg=#585858 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyHeader   guifg=#e6db74 ctermfg=114 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyNumber   guifg=#f8f8f2 ctermfg=215 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifyPath     guifg=#8a8a8a ctermfg=245 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySection  guifg=#dfafaf ctermfg=181 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySelect   guifg=#5fdfff ctermfg=81 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySlash    guifg=#585858 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE
hi StartifySpecial  guifg=#585858 ctermfg=240 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE

" indent line
let g:indentLine_char = '│'

" deoplete
let g:deoplete#enable_at_startup = 1
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file', 'neosnippet']
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1

" Use partial fuzzy matches like YouCompleteMe
call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])

" CtrlP
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_match_window = 'bottom,order:btt,min:10,max:10,results:10'
let g:ctrlp_mruf_max=450 		    " number of recently opened files
let g:ctrlp_switch_buffer = 'et'	" jump to a file if it's open already
let g:ctrlp_max_files=0  		    " do not limit the number of searchable files
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Neomake (sudo pip3 install flake8)
let g:neomake_python_enabled_makers = ['flake8']
autocmd! BufWritePost * Neomake

" Neomake set colors
highlight ErrorSign     ctermbg=black   ctermfg=red
highlight ErrorSign     guibg=none      guifg=red
highlight WarningSign   ctermbg=black   ctermfg=yellow
highlight WarningSign   guibg=none      guifg=yellow

let g:neomake_error_sign = {
            \ 'text': '',
            \ 'texthl': 'ErrorSign',
            \ }

let g:neomake_warning_sign = {
            \ 'text': '',
            \ 'texthl': 'WarningSign',
            \ }

" vim-cfmt
let g:cfmt_style = '-linux'

" NERDTree Git Plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "",
    \ "Staged"    : "",
    \ "Untracked" : "",
    \ "Renamed"   : "",
    \ "Unmerged"  : "",
    \ "Deleted"   : "",
    \ "Dirty"     : "",
    \ "Clean"     : "",
    \ "Unknown"   : ""
    \ }

" DelimitMate
let g:delimitMate_expand_cr = 1		
let g:delimitMate_expand_space = 1		
let g:delimitMate_smart_quotes = 1		
let g:delimitMate_expand_inside_quotes = 0		
let g:delimitMate_smart_matchpairs = '^\%(\w\|\$\)'		

imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"
