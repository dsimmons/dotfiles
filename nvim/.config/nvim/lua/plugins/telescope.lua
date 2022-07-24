require('telescope').setup{}

local bind = vim.keymap.set
local silent = { silent = true }

-- Modified from: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
--
-- If the buffer being editited is part of a git repository, use that as the
-- project root (versus relative to the pwd). Otherwise, fall back to the
-- default `:pwd` behavior.
--
-- Where applicable (Git repo), it makes finding files independent of the
-- spawning terminal's `pwd` and/or allows for using `set autochdir`.
local function project_files()
  local ok = pcall(require('telescope.builtin').git_files)
  if not ok then require('telescope.builtin').find_files() end
end

bind('n', '<Leader>fb', require('telescope.builtin').buffers, silent)
bind('n', '<Leader>fd', require('telescope.builtin').diagnostics, silent)
bind('n', '<Leader>ff', project_files, silent)
bind('n', '<Leader>fg', require('telescope.builtin').live_grep, silent)
bind('n', '<Leader>fh', require('telescope.builtin').help_tags, silent)
bind('n', '<Leader>fw', require('telescope.builtin').grep_string, silent)
