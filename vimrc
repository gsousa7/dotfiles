" ---------------------------------------------
" General Settings
" ---------------------------------------------
set nocompatible                " Disable vi compatibility
set backspace=indent,eol,start  " Allow backspace in insert mode
set encoding=utf-8              " Use UTF-8 encoding
set fileencoding=utf-8          " Ensure files are saved as UTF-8
set clipboard=unnamedplus       " Use system clipboard
set mouse=nv                     " Enable mouse support
set history=1000                " Store 1000 lines of command history
set wildmenu                    " Enhanced command-line completion
set lazyredraw                  " Improve performance for macros/scripts
set visualbell                  " Disables the audible bell and uses a visual flash instead
set t_vb=                       " Disables the visual bell effect
set t_u7=                       " Disables cursor position reporting

" ---------------------------------------------
" Appearance
" ---------------------------------------------
set number                   " Show line numbers
set cursorline               " Highlight the current line
set showmatch                " Highlight matching parenthesis
set ruler                    " Show cursor position
set title                    " Show filename in terminal title
set termguicolors            " Enable 24-bit colors


" ---------------------------------------------
" Indentation
" ---------------------------------------------
set tabstop=4                " Tab character width
set shiftwidth=4             " Indentation width
set expandtab                " Use spaces instead of tabs
set autoindent               " Copy indent from current line
set smartindent              " Automatically insert indents
filetype plugin indent on    " Enable filetype-specific indentation

" ---------------------------------------------
" Search
" ---------------------------------------------
set hlsearch                 " Highlight search results
set incsearch                " Incremental search
set ignorecase               " Ignore case in searches
set smartcase                " Override ignorecase if uppercase letters are used

" ---------------------------------------------
" Plugins
" ---------------------------------------------
call plug#begin('~/.vim/plugged')

" Essential Plugins
Plug 'junegunn/vim-plug'              " Plugin manager
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Airline themes
Plug 'sheerun/vim-polyglot'           " Syntax highlighting for many languages
Plug 'dense-analysis/ale'             " Linting and fixing

call plug#end()

" ---------------------------------------------
" Key Mappings
" ---------------------------------------------
" Quickly save and quit
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>q :q<CR>
nnoremap <silent> <leader>x :x<CR>

" Navigate splits
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Clear search highlights
nnoremap <silent> <leader>/ :noh<CR>


" ---------------------------------------------
" ALE Settings
" ---------------------------------------------
let g:ale_fix_on_save = 1           " Auto-fix on save
let g:ale_linters_explicit = 1      " Use only specified linters
let g:ale_linters = {'python': ['flake8'], 'yaml': ['yamllint'], 'sh': ['shellcheck']}

" ---------------------------------------------
" Other Settings
" ---------------------------------------------
autocmd BufWritePre * %s/\s\+$//e   " Remove trailing whitespace on save
set splitright                     " New vertical splits open to the right
set splitbelow                     " New horizontal splits open below

if v:version < 802
    packadd! dracula
endif
syntax enable
colorscheme dracula