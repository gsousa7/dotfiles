# Install with 
## curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Open vin and run
## :PlugInstall

set mouse-=0
set visualbell
set t_vb=
set t_u7=


" ---------------------------------------------
" General Settings
" ---------------------------------------------
set nocompatible             " Disable vi compatibility
set backspace=indent,eol,start " Allow backspace in insert mode
set encoding=utf-8           " Use UTF-8 encoding
set fileencoding=utf-8       " Ensure files are saved as UTF-8
set clipboard=unnamedplus    " Use system clipboard
set mouse=a                  " Enable mouse support
set history=1000             " Store 1000 lines of command history
set wildmenu                 " Enhanced command-line completion
set lazyredraw               " Improve performance for macros/scripts

" ---------------------------------------------
" Appearance
" ---------------------------------------------
set number                   " Show line numbers
set relativenumber           " Relative line numbers
set cursorline               " Highlight the current line
set showmatch                " Highlight matching parenthesis
set ruler                    " Show cursor position
set title                    " Show filename in terminal title
set termguicolors            " Enable 24-bit colors
colorscheme desert           " Set colorscheme (change as desired)

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
Plug 'preservim/nerdtree'             " File explorer
Plug 'tpope/vim-fugitive'             " Git integration
Plug 'airblade/vim-gitgutter'         " Git diff in gutter
Plug 'vim-airline/vim-airline'        " Status line
Plug 'vim-airline/vim-airline-themes' " Airline themes
Plug 'sheerun/vim-polyglot'           " Syntax highlighting for many languages
Plug 'scrooloose/nerdcommenter'       " Easy commenting
Plug 'dense-analysis/ale'             " Linting and fixing

call plug#end()

" ---------------------------------------------
" Key Mappings
" ---------------------------------------------
" NERDTree Toggle
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

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
" GitGutter Settings
" ---------------------------------------------
let g:gitgutter_map_keys = 0        " Disable default key mappings
nnoremap <leader>hp :GitGutterPreviewHunk<CR>
nnoremap <leader>hs :GitGutterStageHunk<CR>

" ---------------------------------------------
" ALE Settings
" ---------------------------------------------
let g:ale_fix_on_save = 1           " Auto-fix on save
let g:ale_linters_explicit = 1      " Use only specified linters
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}

" ---------------------------------------------
" Other Settings
" ---------------------------------------------
autocmd BufWritePre * %s/\s\+$//e   " Remove trailing whitespace on save
set splitright                     " New vertical splits open to the right
set splitbelow                     " New horizontal splits open below

