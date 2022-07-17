local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- When a pane loses focus, disable its `cursorline` and enable it in the
-- focused pane instead. Basically, only the focused pane should have
-- `cursorline` enabled. Otherwise, it's very visually distracting, and
-- `cursorline` can even blend in with the statusline depending on how your
-- panes are split.
local cursorline = augroup("CursorLine", {})
autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
  group = cursorline,
  pattern = "*",
  command = "setlocal cursorline"
})
autocmd("WinLeave", {
  group = cursorline,
  pattern = "*",
  command = "setlocal nocursorline"
})

-- https://github.com/morhetz/gruvbox/wiki/Installation
autocmd("VimEnter", {
  pattern = "*",
  command = "colorscheme gruvbox",
  nested = true
})
