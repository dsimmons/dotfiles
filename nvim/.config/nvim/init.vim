" ================ General ==========================
set nowrap            " Have long text extend off-screen.
set relativenumber    " Make motion math easier.

" ================ Appearance =======================
set list              " Keep files tidy: show tabs, trailing whitespace, and nbsp.
set cursorline        " Highlight the line the cursor is on to make it easy to see.
set guicursor=        " Disable default cursor styling (skinny cursor in insert mode).
set termguicolors     " Assume we're using a modern terminal, full 24-bit RGB color.

" ================ Indentation ======================
set shiftwidth=2      " Number of spaces to use for (auto)indentation and >>, <<.
set shiftround        " Round indentation to a multiple of `shiftwidth` for consistency.
set tabstop=2         " Number of spaces to use for a tab.
set expandtab         " Pressing <Tab> inserts spaces instead.

" ================ Search ===========================
set ignorecase        " Make searches case-insensitive.
set smartcase         " Override `ignorecase` when caps are used in a search.

" ================ Buffers ==========================
set noswapfile        " Assume we're using version control and/or backups.
set splitright        " When splitting vertically, focus the right.
set splitbelow        " When splitting horizontally, focus the bottom.

" Assumes you've installed https://github.com/junegunn/vim-plug.
" TODO: Create a Makefile that automates this.
"
" Store plugin data at ~/.local/share/nvim/plugged.
call plug#begin(stdpath('data') . '/plugged')

  " An easier way to manage LSP server installations.
  Plug 'williamboman/nvim-lsp-installer'

  " A collection of common configurations for built-in LSP integrations.
  " Handles automatically launching and initializing language servers.
  Plug 'neovim/nvim-lspconfig'

  " LSP-like functionality for tools/utils that aren't true "LSP".
  " e.g. ESLint, shellcheck
  Plug 'jose-elias-alvarez/null-ls.nvim'

  " Modern fuzzy finder.
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'          " Required for Telescope & others.

  " More intelligent parsing, syntax highlighting, etc... (versus regex).
  " Then, based on understanding the underlying syntax better, we can improve
  " upon recognized textobjects and comments (e.g. nested languages).
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'

  " Completion
  Plug 'hrsh7th/nvim-cmp'

  " Snippets
  Plug 'L3MON4D3/LuaSnip'

  " A more modern/useful status line without a ton of extra deps.
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'   " Required for lualine, Telescope.

  " Tpope essentials that I don't know how to function without.
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-surround'

  " Use a better colorscheme.
  Plug 'morhetz/gruvbox'

  " The plugin that I use for my `todo.txt` file for now.
  " See: http://todotxt.org/
  Plug 'https://gitlab.com/dbeniamine/todo.txt-vim'

call plug#end()

" https://github.com/morhetz/gruvbox/wiki/Installation
autocmd vimenter * ++nested colorscheme gruvbox

lua << EOF
  require('nvim-lsp-installer').setup{}

  require('telescope').setup{}
  require('lualine').setup{}

  require('lspconfig').bashls.setup{}
  require('lspconfig').cssls.setup{}
  require('lspconfig').denols.setup{}
  require('lspconfig').dockerls.setup{}
  require('lspconfig').eslint.setup{}
  require('lspconfig').gopls.setup{}
  require('lspconfig').graphql.setup{}
  require('lspconfig').html.setup{}
  require('lspconfig').jsonls.setup{}
  require('lspconfig').marksman.setup{}
  require('lspconfig').pyright.setup{}
  require('lspconfig').rust_analyzer.setup{}
  require('lspconfig').solc.setup{}
  require('lspconfig').sumneko_lua.setup{}
  require('lspconfig').tailwindcss.setup{}
  require('lspconfig').tsserver.setup{}
  require('lspconfig').vimls.setup{}
  require('lspconfig').yamlls.setup{}
EOF

" Overwrite default <Space> behavior.
" Then, map <Space> to be our leader key.
nnoremap <Space> <Nop>
let mapleader=" "

" Make moving between split windows easier.
" eg. <CTRL+W><H> ===> <CTRL+H>
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Convenient chords for editing and reloading the nvim config file.
nnoremap <Leader>ve :e $MYVIMRC<CR>
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Double space to clear hlsearch temporarily.
" Highlighting is automatically re-enabled after another search.
nnoremap <silent> <Leader><Space> :nohlsearch<CR>
