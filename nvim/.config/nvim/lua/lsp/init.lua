require('nvim-lsp-installer').setup {
  automatic_installation = true
}

local bind = vim.keymap.set

local diagnostic = vim.diagnostic
local opts = { silent=true }
bind('n', '<space>e', diagnostic.open_float, opts)
bind('n', '[d', diagnostic.goto_prev, opts)
bind('n', ']d', diagnostic.goto_next, opts)
bind('n', '<space>q', diagnostic.setloclist, opts)

-- Set up mappings using a callback when an LSP server attaches to the current
-- buffer.
local buf = vim.lsp.buf
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { silent=true, buffer=bufnr }
  bind('n', 'gD', buf.declaration, bufopts)
  bind('n', 'gd', buf.definition, bufopts)
  bind('n', 'K', buf.hover, bufopts)
  bind('n', 'gi', buf.implementation, bufopts)
  bind('n', '<C-k>', buf.signature_help, bufopts)
  bind('n', '<space>wa', buf.add_workspace_folder, bufopts)
  bind('n', '<space>wr', buf.remove_workspace_folder, bufopts)
  bind('n', '<space>wl', function()
    print(vim.inspect(buf.list_workspace_folders()))
  end, bufopts)
  bind('n', '<space>D', buf.type_definition, bufopts)
  bind('n', '<space>rn', buf.rename, bufopts)
  bind('n', '<space>ca', buf.code_action, bufopts)
  bind('n', 'gr', buf.references, bufopts)
  bind('n', '<space>f', buf.formatting, bufopts)
end

local enabled_lsps = {
  "bashls",
  "cssls",
  "dockerls",
  "eslint",
  "gopls",
  "graphql",
  "html",
  "jsonls",
  "marksman",
  "pyright",
  "rust_analyzer",
  "solc",
  -- "sumneko_lua",
  "tailwindcss",
  "tsserver",
  "vimls",
  "yamlls"
}

local lspconfig = require('lspconfig')

-- Add our callback to each LSP server we care about.
--
-- TODO: Decide how to handle per-server configuration that requires more than
-- the basic `on_attach` callback. See `sumneko_lua` below as an example.
for _, lsp in ipairs(enabled_lsps) do
  lspconfig[lsp].setup { on_attach = on_attach }
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim).
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Allow the `vim` global.
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files.
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data.
      telemetry = {
        enable = false,
      },
    },
  },
}

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local null_ls = require('null-ls')
null_ls.setup {
  sources = { null_ls.builtins.formatting.prettier }
}
