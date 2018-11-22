set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'Yggdroot/indentLine'
Plug 'ncm2/ncm2'

autocmd BufEnter * call ncm2#enable_for_buffer()

set completeopt=noinsert,menuone,noselect

Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'

Plug 'roxma/nvim-yarp'

call plug#end()

filetype plugin indent on

" Backspace ALL the things!
set backspace=indent,eol,start

"Plugin Starts!
let g:deoplete#enable_at_startup = 1
"let g:indentLine_char = '|'
let g:indentLine_setConceal = 0
let g:ncm2_pyclang#library_path = '/usr/lib64/libclang.so'

"Directory Things, slightly broken, blame @eevee
"set backupdir=~/.vim/backup
set directory=~/.vim/swap
"set writebackup
set undodir=~/.vim/undo
set undofile

syntax on

"Whitespace
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set shiftround
set autoindent
set smartindent
set fileformats=unix,dos

set colorcolumn+=81
set linebreak

set mouse=a

"Encoding
set encoding=utf-8

set nobomb
set fileencodings=uct-bom,utf-8,iso-8859-1

set autoread

"Search Settings
set ignorecase
set smartcase
set incsearch
set showmatch

"Blatantly stolen parenmatch
hi MatchParent cterm=none ctermbg=magenta ctermfg=lightblue
set hlsearch
set gdefault

"Colors!
colorscheme ron

"Give me numbers or give me death
set number relativenumber

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

set ruler

set virtualedit+=block

"Custom Binds
vnoremap <C-c> "+y
"Use C-c to yank to system clip

"Highlight trailing whitespace, because I'm not neurotic enough already
hi WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+\%#\@>!$/

set conceallevel=0

" Keybinds

imap jj <Esc>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let mapleader = ","
