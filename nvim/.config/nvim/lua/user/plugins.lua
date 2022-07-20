-- Bootstrap Packer if not present.
-- https://github.com/wbthomason/packer.nvim#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path
  })
end

-- Ensure `packer` can be required when first bootstrapping.
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Let Packer manage itself.
  use "wbthomason/packer.nvim"

  -- A collection of common configurations for built-in LSP integrations.
  -- Handles automatically launching and initializing language servers.
  use "neovim/nvim-lspconfig"

  -- An easier way to manage LSP server installations.
  use {
    "williamboman/nvim-lsp-installer",
    requires = { "neovim/nvim-lspconfig" }
  }

  -- LSP-like functionality for tools/utils that aren't "true" LSP.
  -- e.g. Prettier, shellcheck
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }

  -- Modern fuzzy finder.
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "kyazdani42/nvim-web-devicons", opt = true }
    }
  }

  -- More intelligent parsing, syntax highlighting, etc... (versus regex). Then,
  -- based on understanding the underlying syntax better, we can improve upon
  -- recognized textobjects and comments (e.g. nested languages).
  use {
    "nvim-treesitter/nvim-treesitter",
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end
  }
  -- use "nvim-treesitter/nvim-treesitter-textobjects"
  -- use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Completion
  use "hrsh7th/nvim-cmp"

  -- Snippets
  use "L3MON4D3/LuaSnip"

  -- A more modern/useful status line without a ton of extra deps.
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true }
  }

  -- Tpope essentials that I don't know how to function without.
  use "tpope/vim-commentary"
  use "tpope/vim-fugitive"
  use "tpope/vim-obsession"
  use "tpope/vim-surround"

  -- Use a better colorscheme.
  use { "ellisonleao/gruvbox.nvim" }

  -- The plugin that I use for my `todo.txt` file for now.
  -- See: http://todotxt.org/
  use "https://gitlab.com/dbeniamine/todo.txt-vim"

  -- Run `:PackerSync` if we're bootstrapping fresh.
  if packer_bootstrap then
    require("packer").sync()
  end
end)
