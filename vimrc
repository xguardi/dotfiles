" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
" Xavier Guardiola's vimrc file
" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
 
" vim-plug manager
call plug#begin('~/.config/nvim/plugged')
" Plugins go here
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'mattn/emmet-vim'
Plug 'mileszs/ack.vim'
Plug 'sophacles/vim-processing'
Plug 'vim-scripts/matchit.zip'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/tComment'
Plug 'chriskempson/base16-vim'
Plug 'kien/ctrlp.vim'
Plug 'jalvesaq/Nvim-R'
Plug 'autowitch/hive.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
" Plug 'klen/python-mode'
call plug#end()

" General
" set encoding=utf-8
set nocompatible      " We're running Vim, not Vi!
set hidden 
set nobackup          " no backup files
set noswapfile
set autoread          " Reload files changed outside vim
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set scrolloff=5      " mantenim sempre unes poques línies de context en el scroll
set showmode 
set showcmd           " Display incomplete commands
set wildmenu          " show automcomplete options on top at the command line
set wildmode=list:longest
set visualbell
set cursorline        " highlight cursor line
set ttyfast           " assume a fast terminal for faster rendering
set ruler             " mostrar la regla que indica fila/columna
set laststatus=2
set number    " shows #lines from currentline instead of absolute
set ls=2
set statusline=%<%f%h%m%r%h%w%y\ %{&ff}\ (%p%%) 
" Indenting
set tabstop=2 
set shiftwidth=2 
set softtabstop=2
set expandtab
set autoindent
" Color scheme
colorscheme solarized
set background=dark
" Leader key
let mapleader = ","
let maplocalleader = ","
let g:mapleader = ","
let g:maplocalleader = ","
" Searching
set ignorecase
set smartcase          " if uppercase in search does case sensitive search
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr> " removes highlighted matches
" Persistent Undo 
set undodir=~/.vim/backups
set undofile
inoremap jj <ESC> " alternative way to <ESC>.
" Window management
nnoremap <leader>w <C-w>v<C-w>l " fast vertical split
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" end word additions (split '.' amd '_')
set iskeyword-=.
set iskeyword-=_

" html coding
nnoremap <leader>ft Vatzf " folds current tag

" Buffers
nmap <C-b> <ESC>:b#<CR>
imap <C-b> <ESC>:b#<CR>
nmap <C-right> <ESC>:bn<CR>
nmap <C-left> <ESC>:bp<CR>

" Tabs
nmap <D-Right> :tabnext<cr>
imap <D-Right> <ESC> :tabnext<cr>
nmap <D-Left> :tabprevious<cr>
imap <D-Left> <ESC> :tabprevious<cr>

" Tab completion

" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Misc
"
" Creates a line of == with the same length as the current line.
nnoremap <leader>1 yypVr= 

" mappings varis
:map <space> <S-Down>

" tags list
set tags=~/.ctags

" autocompletion
set complete=.,w,b,u,t,i 
"set omnifunc=csscomplete#CompleteCSS

" method folding
set foldmethod=marker

" folding column
set foldcolumn=1

" número de línia
" set nu!

",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
map ,v :tabf ~/.vimrc<CR><C-W>_
map <silent> ,V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>
",v brings up my vim tips and tricks help file
map ,h :tabf ~/.vim/vim_tips.md<CR><C-W>

" per recarregar la pàgina
map <F5> :e!<CR>
"

set path+=.

" Pel taglist
let Tlist_Compact_Format=1
let Tlist_Show_Menu=1
"map <silent> <F7> :TlistAddFilesRecursive . *.rb<CR>
map <silent> <F8> :TlistToggle<CR>

" surround
let g:surround_95 = "_(\r)"
let g:surround_63 = "<%= _(\"\r\") %>"
" PHP
autocmd FileType php let b:surround_45 = "<?php \r ?>"

" per gestionar els meus propis fitxers de help
autocmd BufWrite mytips.txt             :helptags ~/.vim/doc/
autocmd BufRead  mytips.txt             set filetype=help
autocmd BufRead  mytips.txt             set noreadonly
autocmd BufRead  mytips.txt             set modifiable
autocmd BufWrite myrails.txt            :helptags ~/.vim/doc/
autocmd BufRead  myrails.txt            set filetype=help
autocmd BufRead  myrails.txt            set noreadonly
autocmd BufRead  myrails.txt            set modifiable

" scss plugin
au BufRead,BufNewFile *.scss set filetype=scss
" less plugin
au BufNewFile,BufRead *.less set filetype=less

" RENAME CURRENT FILE (thanks Gary Bernhardt)
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>

"Markdown to HTML  
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <CR>

" airline
set fillchars=stl:-
set fillchars=stlnc:-


"Vim-R-plugin
" let maplocalleader = ","
" vmap <Space> <Plug>RDSendSelection
" nmap <Space> <Plug>RDSendLine
" map <silent> <LocalLeader>h :call RAction("head")<CR>
" map <silent> <LocalLeader>t :call RAction("str")<CR>
" map <silent> <LocalLeader>p :call RAction("print")<CR>
" " let vimrplugin_applescript=0
" let vimrplugin_vsplit = 0
" " No _ = <-
" let vimrplugin_assign = 0
" " set vim-r-plugin to 
" let r_indent_align_args = 0
" " " Set vim-r-plugin to mimics ess :
" let r_indent_ess_comments = 0
" let r_indent_ess_compatible = 0
" " Colorful R output
" let Rout_more_colors = 1
" " folding enabled
" let r_syntax_folding = 1
" set nofoldenable

" HIVE syntax
" for .hql files
au BufNewFile,BufRead *.hql set filetype=hive expandtab
" for .q files
au BufNewFile,BufRead *.q set filetype=hive expandtab
