require('telescope').setup{}

local bind = vim.keymap.set
local silent = { silent = true }

bind('n', '<Leader>fb', require('telescope.builtin').buffers, silent)
bind('n', '<Leader>fd', require('telescope.builtin').diagnostics, silent)
bind('n', '<Leader>ff', require('telescope.builtin').find_files, silent)
bind('n', '<Leader>fg', require('telescope.builtin').live_grep, silent)
bind('n', '<Leader>fh', require('telescope.builtin').help_tags, silent)
bind('n', '<Leader>fw', require('telescope.builtin').grep_string, silent)
