local opt = vim.opt

-- Map <Space> to be our leader key.
vim.g.mapleader = " "

-- ================ General ==========================
opt.wrap = false            -- Have long text extend off-screen.
opt.relativenumber = true   -- Make motion math easier.

-- ================ Appearance =======================
opt.list = true             -- Keep files tidy: show tabs, trailing whitespace, and nbsp.
opt.cursorline = true       -- Highlight the line the cursor is on to make it easy to see.
opt.guicursor = ''          -- Disable default cursor styling (skinny cursor in insert mode).
opt.termguicolors = true    -- Assume we're using a modern terminal, full 24-bit RGB color.

-- ================ Indentation ======================
opt.shiftwidth = 2          -- Number of spaces to use for (auto)indentation and >>, <<.
opt.shiftround = true       -- Round indentation to a multiple of `shiftwidth` for consistency.
opt.tabstop = 2             -- Number of spaces to use for a tab.
opt.expandtab = true        -- Pressing <Tab> inserts spaces instead.

-- ================ Search ===========================
opt.ignorecase = true       -- Make searches case-insensitive.
opt.smartcase = true        -- Override `ignorecase` when caps are used in a search.

-- ================ Buffers ==========================
opt.swapfile = false        -- Assume we're using version control and/or backups.
opt.splitright = true       -- When splitting vertically, focus the right.
opt.splitbelow = true       -- When splitting horizontally, focus the bottom.
