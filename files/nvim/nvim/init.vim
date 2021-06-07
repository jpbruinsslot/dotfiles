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

" Neovim: auto-create an undo directory
set undofile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"
" Using vim-plug for plugin management:
" https://github.com/junegunn/vim-plug
"
" Common commands
" :PlugInstall      install new plugins
" :PlugUpdate       update current plugins
" :PlugClean        remove unused plugins
" :PlugUpgrade      update vim-plug itself
"
" To get a specific branch:
" Plug 'https://github.com/erroneousboat/neokai', {'branch': 'dev'}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" -> Interface
Plug 'https://github.com/arcticicestudio/nord-vim'                          " colorscheme
Plug 'https://github.com/itchyny/lightline.vim'                             " light and configurable statusline/tabline for vim
Plug 'https://github.com/mhinz/vim-startify'                                " the fancy start screen for Vim.
Plug 'https://github.com/airblade/vim-gitgutter'                            " show a git diff in the gutter(sign column) and stages/reverts hunks
Plug 'https://github.com/liuchengxu/vista.vim'                              " view and search LSP symbols, tags in Vim/NeoVim.
Plug 'https://github.com/ctrlpvim/ctrlp.vim'                                " full path fuzzy file, buffer, mru, tag, ... finder for vim
Plug 'https://github.com/gcmt/taboo.vim'                                    " ease the way you set the vim tabline
Plug 'https://github.com/junegunn/goyo.vim'                                 " distraction-less vim
Plug 'https://github.com/wesq3/vim-windowswap'                              " swap windows without ruining your layout <leader> ww move to window and <leader> ww
Plug 'https://github.com/psliwka/vim-smoothie'                              " smooth scrolling
Plug 'https://github.com/mattn/vim-xxdcursor'                               " cursor that helps navigating with xxd hexdumps
Plug 'https://github.com/kien/rainbow_parentheses.vim'                      " helps you read complex code by showing diff level of parentheses in diff color
Plug 'https://github.com/tpope/vim-fugitive'                                " the premier Vim plugin for Git, used for lightline
Plug 'https://github.com/onsails/lspkind-nvim'                              " adds vscode-like pictograms to neovim built-in lsp
Plug 'https://github.com/kyazdani42/nvim-web-devicons'                      " for file icons

" -> Productivity
Plug 'https://github.com/tomtom/tcomment_vim'                               " an extensible & universal comment vim-plugin that also handles embedded filetypes
Plug 'https://github.com/tpope/vim-surround'                                " quoting/parentesizing made simple
Plug 'https://github.com/Yggdroot/indentLine'                               " identation line

" https://github.com/neoclide/coc.nvim/wiki/Language-servers
Plug 'https://github.com/neoclide/coc.nvim', { 'branch': 'release' }
Plug 'https://github.com/kevinoid/vim-jsonc'

Plug 'https://github.com/junegunn/fzf' , { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/mg979/vim-visual-multi', {'branch': 'master'}      " multiple cursors
Plug 'https://github.com/rhysd/vim-grammarous'
Plug 'https://github.com/francoiscabrol/ranger.vim'
Plug 'https://github.com/jiangmiao/auto-pairs'                              " insert or delete brackets, parens, quotes in pair.

" -> Programming languages specific plugins

" Go
Plug 'https://github.com/fatih/vim-go', {'do': ':GoUpdateBinaries'}

" Rust
Plug 'https://github.com/rust-lang/rust.vim'

" JavaScript

" Filetype plugins (syntax highlighting)
Plug 'https://github.com/sheerun/vim-polyglot'
Plug 'https://github.com/ekalinin/Dockerfile.vim'
Plug 'https://github.com/mxw/vim-jsx'
Plug 'https://github.com/elzr/vim-json'
Plug 'https://github.com/vim-pandoc/vim-pandoc'
Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax'

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

" disable cursor styling
set guicursor=

" line separator character
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

" visual autocomplete for command menu, tab autocompletion
set wildmenu
set wildmode=list:full
set wildignore+=.hg,,.svn                        " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files

" highlight matching [{()}]
set showmatch

" redraw only when we need to
set lazyredraw

" disable background erase, background color will work in tmux
set t_ut=

" remove default vim mode information
set noshowmode

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

" Show syntax highlighting groups for word under cursor, this is
" helpful when creating/updating color schemas
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

" never do this again --> :set paste <ctrl-v> :set no paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

" cursor can move freely
set virtualedit=all

" always use the clipboard for all operations
" set clipboard+=unnamedplus

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
colorscheme nord
" hi CursorLine guibg=#3D3D3D
" hi Normal guibg=#2A2A2A

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
"
" Leader is comma
let mapleader=","

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
" inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Running a macro
" 1. Start recording keystrokes by typing qq
" 2. End recording with q
" 3. Play recorded keystrokes by hitting space
:noremap <Space> @q

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype settings
" https://github.com/jessfraz/.vim/blob/8271e5f6bd4aec7a586b430c21e82c22ce90e83b/vimrc#L319
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" au BufNewFile,BufRead *.txt setlocal noet ts=4 sw=4
" au BufNewFile,BufRead *.md setlocal spell noet ts=4 sw=4

" Markdown Settings
" autocmd BufNewFile,BufReadPost *.md setl ts=4 sw=4 sts=4 expandtab

" filetype specific tabs
" ts    number of spaces
" sts   number of spaces 'tab' uses
" sw    number of spaces to use for (auto) indent step
autocmd FileType javascript setlocal ts=2 sts=2 sw=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" VimGo: enable goimports to automatically insert import paths instead of gofmt
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 0
let g:go_autodetect_gopath = 1
let g:go_fmt_autosave = 1
let g:go_snippet_engine = "neosnippet"

" VimGo: syntax highlighting for functions, methods and structs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>l <Plug>(go-metalinter)

au FileType go nmap <leader>r  <Plug>(go-run)

au FileType go nmap <leader>b  <Plug>(go-build)
au FileType go nmap <leader>t  <Plug>(go-test)
au FileType go nmap <leader>dt  <Plug>(go-test-compile)
au FileType go nmap <Leader>d <Plug>(go-doc)

au FileType go nmap <Leader>e <Plug>(go-rename)

" neovim specific
if has('nvim')
  au FileType go nmap <leader>rt <Plug>(go-run-tab)
  au FileType go nmap <Leader>rs <Plug>(go-run-split)
  au FileType go nmap <Leader>rv <Plug>(go-run-vertical)
endif

" LightLine: configuration
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive', 'filename' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'MyFugitive',
    \   'readonly': 'MyReadonly',
    \   'modified': 'MyModified',
    \   'filename': 'MyFilename',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

" LightLine: coc.vim intgration
function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" LightLine: Will add `+` next to file name when file has changed
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

" LightLine: Will show `` when file is Read Only
function! MyReadonly()
    if &filetype == "help"
        return ""
    elseif &readonly
        return ""
    else
        return ""
    endif
endfunction

" LightLine: Will make use of plugin Fugitive to show branch and `` icon
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

" Tmux: allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Startify: configurations (used figlet -f slant [text] for ascii text)
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
let g:startify_change_to_vcs_root = 1
let g:startify_enable_special = 0

let g:startify_list_order = ['sessions', 'bookmarks', 'files']

let g:startify_bookmarks = [
    \ '~/Projects',
    \ ]

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'commands',  'header': ['   Commands']       },
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

" Indent Line: configuration
" let g:indentLine_char = '│'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_color_gui = '#434C5E'
let g:indentLine_color_term = 8

" CtrlP: configuration
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:btt,min:10,max:10,results:10'
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" CtrlP: number of recently opened files
let g:ctrlp_mruf_max=450

" CtrlP: jump to a file if it's open already
let g:ctrlp_switch_buffer = 'et'

" CtrlP: do not limit the number of searchable files
let g:ctrlp_max_files=0

" CtrlP: local working directory
" n: nearest ancestor of current file, that contains one of these directories
"    , .hg, .svn, .bzr
" a: directory of the current file, unless it is a directory of the cwd
let g:ctrlp_working_path_mode = 'ra'

" CtrlP: cache
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0

" FZF

" FZF: This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" FZF: An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" FZF: Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10split enew' }

" FZF: Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" FZF: Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Taboo: keymapping
" {i}gt         go to tab in position i
nnoremap tr :TabooRename<space>

" Taboo: remember tabnames when you save the current session
set sessionoptions+=tabpages,globals

" Taboo: tab format
" %N            tabnumber number on each tab
" %m            modified flag
" %f            name of the first buffer open in the tab
let g:taboo_tab_format = ' %N %f %m '

" Taboo: renamed tab format
" %N            tabnumber number on each tab
" %l            custom tab name
" %m            modified flag
let g:taboo_renamed_tab_format = ' %N %l %m '

" Taboo: modified flag
let g:taboo_modified_tab_flag = '•'

" vim-json
let g:vim_json_syntax_conceal = 0

" Pandoc; remove folding column
let g:pandoc#folding#fdc = 0
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ["go", "python", "c", "cpp", "rust", "javascript"]

" vim-grammarous
"
" Download LanguageTool
nmap <F5> :GrammarousCheck<CR>
nmap <F6> <Plug>(grammarous-move-to-next-error)<CR>
" let g:grammarous#languagetool_cmd = 'docker run -t --entrypoint java -v $HOME/.config/nvim/plugged/vim-grammarous/misc/LanguageTool-4.9:/LanguageTool -v /tmp:/tmp openjdk:8-jre-alpine -jar /LanguageTool/languagetool-commandline.jar $@'
let g:grammarous#languagetool_cmd = 'docker run -v /tmp:/tmp -t ltool-cli $@'

" vim-gitgutter
set signcolumn=yes

highlight SignColumn      guibg=none
highlight GitGutterAdd    guifg=#A6E22E
highlight GitGutterChange guifg=#FD971F  gui=bold
highlight GitGutterDelete guifg=#F92672  gui=bold

let g:gitgutter_highlight_lines = 0
let g:gitgutter_realtime        = 1
let g:gitgutter_eager           = 1

let g:gitgutter_sign_added                   = '┃'
let g:gitgutter_sign_modified                = '┃'
let g:gitgutter_sign_removed                 = '┃'
let g:gitgutter_sign_removed_first_line      = '‾'
let g:gitgutter_sign_removed_above_and_below = '_¯'
let g:gitgutter_sign_modified_removed        = '~_'

" let g:gitgutter_sign_added = '✚'
" let g:gitgutter_sign_modified = '~'
" let g:gitgutter_sign_removed = '━'
" let g:gitgutter_sign_removed_first_line = '^^'
" let g:gitgutter_sign_removed_above_and_below = '{'
" let g:gitgutter_sign_modified_removed = 'ww'

" isort
let g:isort_command = 'isort'

" vim-visual-multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n

" rainbow_parentheses: always on
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces

"
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" vista.vim
nmap <F8> :Vista coc<CR>

" coc.nvim

" Install extensions
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
let g:coc_global_extensions = [
      \'coc-clangd',
      \'coc-css',
      \'coc-diagnostic',
      \'coc-eslint',
      \'coc-explorer',
      \'coc-fzf-preview',
      \'coc-go',
      \'coc-json',
      \'coc-html',
      \'coc-markdownlint',
      \'coc-pyright',
      \'coc-prettier',
      \'coc-rust-analyzer',
      \'coc-sh',
      \'coc-sql',
      \'coc-swagger',
      \'coc-tsserver',
      \'coc-vetur',
      \'coc-yaml',
      \]

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

nnoremap <C-n> :CocCommand explorer<CR>

" nvim-tree.lua
" https://github.com/kyazdani42/nvim-tree.lua
" nnoremap <C-n> :NvimTreeToggle<CR>
"
" let g:nvim_tree_tab_open = 1
" let g:nvim_tree_special_files = []
" let g:nvim_tree_ignore = [ '.git', '.ropeproject', '.mypy_cache']
"
" let g:nvim_tree_icons = {
"     \ 'default': '',
"     \ 'symlink': '',
"     \ 'git': {
"     \   'unstaged': "✗",
"     \   'staged': "✓",
"     \   'unmerged': "",
"     \   'renamed': "➜",
"     \   'untracked': "★",
"     \   'deleted': ""
"     \   },
"     \ 'folder': {
"     \   'default': "",
"     \   'open': "",
"     \   'empty': "",
"     \   'empty_open': "",
"     \   'symlink': "",
"     \   'symlink_open': "",
"     \   }
"     \ }
