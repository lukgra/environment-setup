-- init.lua
-- Order matters: settings first, then keymaps/autocmds, then plugins, then LSP.

-- Core
require("settings")
require("keymaps")
require("autocmds")

-- Plugins
require("plugins.theme")
require("plugins.treesitter")
require("plugins.fzf")
require("plugins.gitsigns")
require("plugins.neo-tree")
require("plugins.which-key")
require("plugins.guess-indent")
require("plugins.buffers")
require("plugins.linebar")
require("plugins.formatting")

-- LSP
require("lsp")

vim.opt.exrc = true
vim.opt.secure = true -- prevents shell commands in local configs
