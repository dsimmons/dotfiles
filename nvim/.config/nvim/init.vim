let mapleader=","

" Assumes you've installed https://github.com/junegunn/vim-plug.
" TODO: Create a Makefile that automates this.
"
" Store plugin data at ~/.local/share/nvim/plugged.
call plug#begin(stdpath('data') . '/plugged')

  " A collection of common configurations for the built-in LSP.
  " Handles automatically launching and initializing language servers.
  Plug 'neovim/nvim-lspconfig'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-surround'

call plug#end()

" Make moving between split windows easier.
" eg. <CTRL+W><H> ===> <CTRL+H>
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Edit config.
nnoremap <Leader>ve :e $MYVIMRC<CR>
" Reload config.
nnoremap <Leader>vr :source $MYVIMRC<CR>

" Double space to clear hlsearch temporarily.
" Highlighting is automatically re-enabled after another search.
nnoremap <Leader><Space> :nohlsearch<CR>
