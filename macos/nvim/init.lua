-- init.lua
-- Order matters: settings first, then keymaps/autocmds, then plugins, then LSP.

require("settings")
require("keymaps")
require("autocmds")

-- -- Plugins (each file calls vim.pack.add + setup internally)
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
--
-- -- LSP (depends on plugins above being loaded first)
require("lsp")
