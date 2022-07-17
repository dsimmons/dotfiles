require('nvim-lsp-installer').setup {
  automatic_installation = true
}

-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local null_ls = require('null-ls')
null_ls.setup {
  sources = { null_ls.builtins.formatting.prettier }
}

local lspconfig = require('lspconfig')
lspconfig.bashls.setup{}
lspconfig.cssls.setup{}
lspconfig.dockerls.setup{}
lspconfig.eslint.setup{}
lspconfig.gopls.setup{}
lspconfig.graphql.setup{}
lspconfig.html.setup{}
lspconfig.jsonls.setup{}
lspconfig.marksman.setup{}
lspconfig.pyright.setup{}
lspconfig.rust_analyzer.setup{}
lspconfig.solc.setup{}
lspconfig.sumneko_lua.setup{}
lspconfig.tailwindcss.setup{}
-- lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}
