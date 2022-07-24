local bind = vim.keymap.set
local opts_silent = { silent = true }

-- Make moving between split windows easier.
-- eg. <CTRL+W><H> ===> <CTRL+H>
bind('n', '<C-h>', '<C-w>h', opts_silent)
bind('n', '<C-j>', '<C-w>j', opts_silent)
bind('n', '<C-k>', '<C-w>k', opts_silent)
bind('n', '<C-l>', '<C-w>l', opts_silent)

-- Change `:pwd` to be the dir of the file being edited, in cases where
-- `set autochdir` isn't feasible or appropriate.
--
-- `:lcd` (vs `:cd`) only affects the current buffer.
bind('n', '<Leader>cd', ':lcd %:p:h<CR>')

-- Convenient chords for editing and reloading the nvim config file.
bind('n', '<Leader>ve', ':e $MYVIMRC<CR>')
bind('n', '<Leader>vr', ':source $MYVIMRC<CR>')

-- Double space to clear hlsearch temporarily.
-- Highlighting is automatically re-enabled after another search.
bind('n', '<Leader><Space>', ':nohlsearch<CR>', opts_silent)
