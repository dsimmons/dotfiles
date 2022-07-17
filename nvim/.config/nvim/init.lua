require('settings')
require('keymaps')
require('commands')
require('plugins')

require('nvim-lsp-installer').setup {
  automatic_installation = true
}

require('telescope').setup{}
require('lualine').setup{}
require('null-ls').setup{}

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
lspconfig.tsserver.setup{}
lspconfig.vimls.setup{}
lspconfig.yamlls.setup{}
