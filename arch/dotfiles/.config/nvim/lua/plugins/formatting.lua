-- lua/plugins/formatting.lua
vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })
 
require('conform').setup({
  notify_on_error = false,
  format_on_save  = { timeout_ms = 500, lsp_format = 'fallback' },
  formatters_by_ft = {
    lua             = { 'stylua' },
    python          = { 'ruff_format' },
    javascript      = { 'prettierd' },
    typescript      = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    json            = { 'prettierd' },
    css             = { 'prettierd' },
    html            = { 'prettierd' },
    markdown        = { 'prettierd' },
    yaml            = { 'prettierd' },
    sh              = { 'shfmt' },
  },
})
