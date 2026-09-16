" =============================================
" SIMPLE VIM CONFIGURATION FOR EDITING
" =============================================

" ---------------------------------------------
" General Settings
" ---------------------------------------------
set nocompatible                " Use Vim features, not Vi
set backspace=indent,eol,start  " Backspace works everywhere
set encoding=utf-8              " UTF-8 encoding
set clipboard=unnamedplus       " Use system clipboard
set mouse=nv                    " Mouse in normal/visual mode
set history=1000                " Command history
set wildmenu                    " Command completion
set lazyredraw                  " Faster macros
set visualbell t_vb=            " No beeping

" Visual settings
set scrolloff=8                 " Keep 8 lines visible above/below cursor
set showcmd                     " Show command being typed
set laststatus=2                " Always show status line
set noshowmode                  " Airline shows mode

" File management
set noswapfile                  " No .swp files
set nobackup                    " No backup files
set undofile                    " Persistent undo
set undodir=~/.vim/undodir      " Undo directory

" ---------------------------------------------
" Appearance
" ---------------------------------------------
set number                      " Line numbers
set cursorline                  " Highlight current line
set showmatch                   " Highlight matching brackets
set ruler                       " Show cursor position
set termguicolors               " 24-bit colors
set splitright                  " Splits open right
set splitbelow                  " Splits open below

" ---------------------------------------------
" Indentation
" ---------------------------------------------
set tabstop=4                   " Tab width
set shiftwidth=4                " Indent width
set expandtab                   " Spaces not tabs
set autoindent                  " Auto indent
set smartindent                 " Smart indent
filetype plugin indent on       " Filetype indentation

" ---------------------------------------------
" Search
" ---------------------------------------------
set hlsearch                    " Highlight search results
set incsearch                   " Search as you type
set ignorecase                  " Ignore case
set smartcase                   " Unless uppercase used

" ---------------------------------------------
" Plugins
" ---------------------------------------------
" Let vim-markdown own markdown instead of polyglot's bundled copy
let g:polyglot_disabled = ['markdown']

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Themes
Plug 'sheerun/vim-polyglot'           " Syntax highlighting
Plug 'dense-analysis/ale'             " Linting/fixing
Plug 'frazrepo/vim-rainbow'           " Rainbow brackets
Plug 'tpope/vim-fugitive'             " Git commands
Plug 'airblade/vim-gitgutter'         " Git diff markers
Plug 'jiangmiao/auto-pairs'           " Auto-close brackets
Plug 'tpope/vim-commentary'           " Easy comments
Plug 'preservim/vim-markdown'         " Markdown folding, TOC, tables
Plug 'dhruvasagar/vim-table-mode'     " Table formatting/alignment
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" ---------------------------------------------
" Key Mappings
" ---------------------------------------------
let mapleader = " "

" Save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Clear search
nnoremap <leader>/ :noh<CR>

" Split navigation (if you use them)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Visual mode - indent
vnoremap < <gv
vnoremap > >gv

" Visual mode - move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Edit/reload vimrc
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" ---------------------------------------------
" Mouse Settings
" ---------------------------------------------
vnoremap <LeftRelease> "+y`>

" ---------------------------------------------
" Plugin Settings
" ---------------------------------------------
" Rainbow parentheses
let g:rainbow_active = 1

" ALE linting
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'

let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\   'yaml': ['yamllint'],
\   'sh': ['shellcheck'],
\   'bash': ['shellcheck'],
\}

let g:ale_fixers = {
\   'python': ['black', 'isort'],
\   'sh': ['shfmt'],
\   'bash': ['shfmt'],
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> [e <Plug>(ale_previous_wrap)

" vim-markdown
let g:vim_markdown_folding_disabled = 0        " fold by header
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_conceal = 0                 " keep *, _, [] etc. visible
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_frontmatter = 1             " YAML frontmatter highlighting
let g:vim_markdown_toc_autofit = 1             " :Toc window fits content width
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_auto_insert_bullets = 0     " don't auto-insert '-' on <CR>
let g:vim_markdown_no_extensions_in_markdown = 1

" vim-table-mode
let g:table_mode_corner = '|'                  " GFM-compatible table corners

" ---------------------------------------------
" Auto Commands
" ---------------------------------------------
" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Return to last position
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Language-specific
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType sh,bash setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType markdown setlocal wrap linebreak spell foldlevel=99
autocmd FileType markdown nnoremap <buffer> <leader>mt :Toc<CR>
autocmd FileType markdown nnoremap <buffer> <leader>mm :TableModeToggle<CR>

" ---------------------------------------------
" Theme
" ---------------------------------------------
syntax enable
colorscheme dracula