-- Modified from: https://www.lazyvim.org/plugins/colorscheme

return {
  -- Additional colorschemes to fetch.
  { "catppuccin/nvim" },
  { "ellisonleao/gruvbox.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon" },
  },

  -- Load/use the colorscheme.
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
