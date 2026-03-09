" Minimal vim config — Tokyo Night-inspired
" Works out of the box with no plugins

" ── General ──────────────────────────────────────────────────────
set nocompatible
filetype plugin indent on
syntax on

set encoding=utf-8
set hidden
set mouse=a
set clipboard=unnamedplus
set backspace=indent,eol,start
set updatetime=300
set timeoutlen=500

" ── Display ──────────────────────────────────────────────────────
set number
set relativenumber
set cursorline
set signcolumn=yes
set showmatch
set scrolloff=8
set sidescrolloff=8
set laststatus=2
set showcmd
set wildmenu
set wildmode=longest:full,full

" ── Indentation ──────────────────────────────────────────────────
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set autoindent

" ── Search ───────────────────────────────────────────────────────
set incsearch
set hlsearch
set ignorecase
set smartcase

" ── Splits ───────────────────────────────────────────────────────
set splitbelow
set splitright

" ── File handling ────────────────────────────────────────────────
set nobackup
set nowritebackup
set noswapfile
set undofile
set undodir=~/.local/state/vim/undo
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" ── Statusline ───────────────────────────────────────────────────
set statusline=%f\ %m%r%h%w\ %=%y\ [%l/%L:%c]\ %p%%

" ── Keymaps ──────────────────────────────────────────────────────
let mapleader = " "

" Clear search highlight
nnoremap <Esc> :nohlsearch<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Move lines up/down in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Keep cursor centered when scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Quick save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" ── Tokyo Night Storm colors ─────────────────────────────────────
" Enable true color (needed inside tmux)
if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
set background=dark

hi Normal        guifg=#c0caf5 guibg=#24283b
hi CursorLine    guibg=#292e42
hi CursorLineNr  guifg=#7aa2f7 guibg=#292e42
hi LineNr        guifg=#565f89
hi Comment       guifg=#565f89 gui=italic
hi String        guifg=#9ece6a
hi Keyword       guifg=#bb9af7
hi Function      guifg=#7aa2f7
hi Type          guifg=#2ac3de
hi Constant      guifg=#ff9e64
hi Number        guifg=#ff9e64
hi Boolean       guifg=#ff9e64
hi Identifier    guifg=#c0caf5
hi Statement     guifg=#bb9af7
hi PreProc       guifg=#7dcfff
hi Special       guifg=#7dcfff
hi Error         guifg=#f7768e guibg=NONE
hi Todo          guifg=#e0af68 gui=bold
hi Visual        guibg=#414868
hi Search        guifg=#24283b guibg=#e0af68
hi IncSearch     guifg=#24283b guibg=#ff9e64
hi Pmenu         guifg=#c0caf5 guibg=#1f2335
hi PmenuSel      guifg=#24283b guibg=#7aa2f7
hi StatusLine    guifg=#c0caf5 guibg=#1f2335
hi StatusLineNC  guifg=#565f89 guibg=#1f2335
hi VertSplit     guifg=#565f89 guibg=NONE
hi SignColumn    guibg=#24283b
hi MatchParen    guifg=#ff9e64 gui=bold
hi Directory     guifg=#7aa2f7
hi Title         guifg=#7aa2f7 gui=bold
hi DiffAdd       guifg=#9ece6a guibg=#1f2335
hi DiffChange    guifg=#e0af68 guibg=#1f2335
hi DiffDelete    guifg=#f7768e guibg=#1f2335
hi TabLine       guifg=#565f89 guibg=#1f2335
hi TabLineSel    guifg=#c0caf5 guibg=#24283b gui=bold
hi TabLineFill   guibg=#1f2335
