-- init.lua
-- Order matters: settings first, then keymaps/autocmds, then plugins, then LSP.

-- Core
require("settings")
require("keymaps")
require("autocmds")

-- Plugins
require("plugins.buffers")
require("plugins.colorizer")
require("plugins.formatting")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.guess-indent")
require("plugins.linebar")
require("plugins.neo-tree")
require("plugins.theme")
require("plugins.treesitter")
require("plugins.which-key")

-- LSP
require("lsp")

vim.opt.exrc = true
vim.opt.secure = true -- prevents shell commands in local configs
