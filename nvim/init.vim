let mapleader=","

" Assumes you've installed https://github.com/junegunn/vim-plug.
" TODO: Create a Makefile that automates this.
"
" Store plugin data at ~/.local/share/nvim/plugged.
call plug#begin(stdpath('data') . '/plugged')

  " A collection of common configurations for the built-in LSP.
  " Handles automatically launching and initializing language servers.
  Plug 'neovim/nvim-lspconfig'

call plug#end()

" Make moving between split windows easier.
" eg. <CTRL+W><H> ===> <CTRL+H>
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
