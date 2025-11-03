  function! DeleteTrailingWhiteSpace()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
  endfunc

  let mapleader = ","
  let g:mapleader = ","
  let maplocalleader = "\\"

  filetype plugin indent on

  set exrc
  set guicursor=
  set relativenumber
  set hidden
  set number
  set noswapfile
  set nobackup
  set nowritebackup
  set undodir=~/.vim/undodir
  set undofile
  set incsearch
  set scrolloff=8
  set expandtab
  set smarttab
  set shiftwidth=2
  set tabstop=2
  set autoindent
  set smartindent
  " set wrap
  " set wrapmargin=2
  set noerrorbells
  set novisualbell
  set colorcolumn=80
  set signcolumn=yes
  set termguicolors
  set autoread
  set clipboard=unnamedplus
  set noshowcmd
  set encoding=utf8
  set ffs=unix,dos,mac
  set backspace=eol,start,indent
  set whichwrap+=<,>,h,l
  set hlsearch
  set showmatch
  set timeoutlen=500
  set synmaxcol=1000
  set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
  set list
  set breakindent
  set breakindentopt=shift:2,min:40,sbr
  set linebreak
  set shada^=%
  set completeopt=menu,menuone,noselect
  set laststatus=3
  set noacd

  " =========================================
  " Mappings
  " =========================================
  nmap <leader>w :w!<cr>
  map 0 ^
  map <space> /
  map <c-space> ?
  map <C-j> <C-W>j
  map <C-k> <C-W>k
  map <C-h> <C-W>h
  map <C-l> <C-W>l

  nnoremap <leader>p <cmd>Telescope find_files<cr>
  nnoremap ; <cmd>Telescope buffers<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
  nnoremap <leader>td <cmd>lua require("trouble").open('diagnostics')<cr>
  nnoremap <leader>tb <cmd>lua require("trouble").open('diagnostics_buffer')<cr>
  nnoremap <leader>ti <cmd>lua vim.diagnostic.enable(not vim.diagnostic.is_enabled())<cr>
  nnoremap <leader>nd <cmd>lua require("noice").cmd("dismiss")<cr>

  " =========================================
  " Initialization commands
  " =========================================
  augroup tcione
    autocmd!
    autocmd BufWrite * :call DeleteTrailingWhiteSpace()
    " Return to last edit position when opening files
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
  augroup END

  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup END
