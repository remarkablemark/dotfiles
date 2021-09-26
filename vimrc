" Before Vundle initializes, required
set nocompatible
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
Plugin 'Quramy/tsuquyomi'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'prettier/vim-prettier'
Plugin 'preservim/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dense-analysis/ale'

" All of your Plugins must be added before the following line
call vundle#end()
" filetype detection[ON] plugin[ON] indent[ON]
filetype plugin indent on

" display settings
set background=light          " enable for light terminals
"set nowrap                   " do not wrap lines
set scrolloff=2               " 2 lines above/below cursor when scrolling
set number                    " show line numbers
set ruler                     " always show info at bottom
set showmatch                 " show matching bracket
set showmode                  " show mode in status bar
set showcmd                   " show typed command in status bar
set title                     " show file in titlebar
set wildmenu                  " completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
"set laststatus=2             " use 2 lines for the status bar
set matchtime=2               " show matching bracket for 0.2 seconds
set matchpairs+=<:>           " match html bracket pair

" editor settings
set esckeys                   " map missed escape sequences (enables keypad keys)
set ignorecase                " case-insensitive searching
set smartcase                 " but become case-sensitive when uppercase characters are typed
set magic                     " change the way backslashes are used in search patterns
set backspace=2               " allow backspace to delete indent, eol, start (any text in insert mode)
"set smartindent              " smart auto-indenting
set autoindent                " indent at the same level as the previous line
"set smarttab                 " use tabs at the start of a line, spaces elsewhere
set tabstop=2                 " indent every 2 columns
set softtabstop=2             " let backspace delete indent
set shiftwidth=2              " indent/outdent by 2 columns
set shiftround                " always indent to the nearest tabstop
set expandtab                 " use spaces instead of tabs

" system settings
set lazyredraw                " no redraws in macros
set confirm                   " get a dialog when :q, :w, or :wq fails
set nobackup                  " no backup ~ files
set viminfo='20,\"500         " remember copy registers after quitting in the .viminfo file
set hidden                    " remember undo after quitting
set history=50                " keep 50 lines of command history
set mouse=a                   " enable mouse support

" color settings (if supported)
if &t_Co > 2 || has('gui_running')
    " enable 256-color mode
    set t_Co=256
    " enable syntax highlighting
    syntax on

    " solarized colorscheme
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    colorscheme solarized

    " line number color
    highlight LineNr cterm=NONE ctermfg=7 ctermbg=NONE gui=NONE
    " highlight cursor line
    set cursorline
    highlight CursorLine cterm=NONE ctermbg=255
    highlight CursorLineNr cterm=NONE " do not underline cursor line number
    " highlight as you type your search
    set incsearch
    highlight IncSearch ctermfg=Yellow ctermbg=DarkGray
    " highlight search results
    set hlsearch
    highlight Search ctermfg=Yellow ctermbg=DarkGray
    " visual mode highlight color
    highlight Visual ctermfg=254 ctermbg=237

    " tab labels which are not active
    highlight TabLine     ctermfg=240 ctermbg=254
    " remaining tabeline with no labels (background)
    highlight TabLineFill ctermfg=240 ctermbg=254
    " current active tab label
    highlight TabLineSel  ctermfg=24  ctermbg=255
endif

""
" vim-airline
" https://github.com/vim-airline/vim-airline
""
let g:airline_theme='papercolor'
" display ALE errors in statusline
let g:airline#extensions#ale#enabled=1

""
" YouCompleteMe
" https://github.com/ycm-core/YouCompleteMe
""
autocmd CompleteDone * pclose " close Omni-Completion tip window when selection is made
" when set to 0, this option turns off YCM's identifier completer (the as-you-type-popup)
"let g:ycm_auto_trigger=0

""
" NERDTree
" https://github.com/preservim/nerdtree
""
let NERDTreeShowHidden=1      " show hidden files
let NERDTreeIgnore=['\.swp$'] " ignore files with swp extension
map <C-n> :NERDTreeToggle<CR> " open NERDTree with Ctrl-N
" autocmd vimenter * NERDTree " open a NERDTree automatically when vim starts up

""
" CtrlP
" https://github.com/ctrlpvim/ctrlp.vim
""
let g:ctrlp_custom_ignore = 'node_modules\|git\|DS_Store'
let g:ctrlp_working_path_mode = ''

""
" The Silver Searcher
" https://robots.thoughtbot.com/faster-grepping-in-vim
""
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" nnoremap \ :Ag<SPACE>

""
" vim-prettier
" https://github.com/prettier/vim-prettier/tree/master#configuration
""
let g:prettier#autoformat = 1
let g:prettier#config#config_precedence = 'prefer-file'
let g:prettier#exec_cmd_async = 1
let blacklist = ['package.json']
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*yaml,*.html if index(blacklist, @%) < 0 | PrettierAsync

""
" ALE
" https://github.com/dense-analysis/ale#usage
""
let g:ale_linters = {
\  'javascript': ['eslint'],
\  'typescript': ['tsserver', 'eslint']
\}
let g:ale_linters#javascript = ['eslint']
let g:ale_linters#typescript = ['tsserver', 'eslint']

let b:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint']
\}
let g:ale_fix_on_save = 1
