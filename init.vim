" xguardi's .vimrc / init.vim file

" Plugins
call plug#begin()
Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'Vigemus/iron.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'liuchengxu/vim-which-key'
Plug 'tmhedberg/SimpylFold'
Plug 'Valloric/YouCompleteMe'   " Syntax autocomplete
Plug '/usr/local/opt/fzf'       " Fuzzy File Finder
Plug 'junegunn/fzf.vim'         " Fuzzy File Finder
Plug 'tpope/vim-obsession'  " Continuously updated session files
call plug#end()

" Leader key
let mapleader = ","
let maplocalleader = ","
let g:mapleader = ","
let g:maplocalleader = ","

set encoding=utf-8
set nocompatible      " We're running Vim, not Vi!
set hidden 
set nobackup          " no backup files
set noswapfile
set autoread          " Reload files changed outside vim
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set scrolloff=5      	" mantenim sempre unes poques línies de context en el scroll
set showmode 
set showcmd           " Display incomplete commands
set visualbell
set ruler             " mostrar la regla que indica fila/columna
set relativenumber	  " relative line numbering
set number		      " set absolute number as well!
set cursorline        " highlight cursor line
set laststatus=2

" Treat _ as a word
set iskeyword-=_

" True colors
if (has("termguicolors"))
  set termguicolors
endif

" Color scheme
set background=dark
colorscheme palenight

" The new app touchbar on the new macbook sucks. A virtual ESC button is no
" button at all.
inoremap jj <ESC> " alternative way to <ESC>.

" Searching
set ignorecase
set smartcase          " if uppercase in search does case sensitive search
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr> " removes highlighted matches

" spell 
set spell spelllang=ca,en_us
set nospell " deactivated by default

" Change highlight bad spell for a simple underline
"hi clear SpellBad
"hi SpellBad cterm=underline


",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
map ,v :e ~/.config/nvim/init.vim<CR><C-W>_
map <silent> ,V :source ~/.config/nvim/init.vim<CR>:filetype detect<CR>:exe ":echo 'init.vim reloaded'"<CR>

",v brings up my vim cheat sheet file
map ,h :e ~/.config/nvim/vim_cheatsheet.md<CR><C-W>

" per recarregar la pàgina
map <F5> :e!<CR>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open current html on the browser
autocmd FileType html nnoremap <leader>b :exe ':silent !open -a /Applications/Google\ Chrome.app %'<CR>
" for html files, 2 spaces
autocmd FileType html setlocal ts=2 sw=2 expandtab

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
" See the docstrings for folded code (SimplyFold plugin)
let g:SimpylFold_docstring_preview=1
let g:SimpylFold_fold_import=0

" Python stuff
" PEP 8 compilance
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" google's yapf python formatter
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" iron.vim (REPL) mappings
" Map iron.vim
nnoremap <leader>r <Plug>(iron-send-motion)
vnoremap <leader>r <Plug>(iron-send-motion)

" Neovim terminal stuff
if has('nvim')
    " Exit terminal model with Esc
    tnoremap <Esc> <C-\><C-n>
endif

" FZF Fuzzy File Finder
nnoremap <C-p> :<C-u>FZF<CR>

