-- lua/plugins/theme.lua
vim.pack.add({ "https://github.com/catppuccin/nvim" })

require("catppuccin").setup({
  flavour = "frappe",
  transparent_background = true,
  integrations = {
    treesitter = true,
    gitsigns = true,
    fzf = true,
    neo_tree = true,
    which_key = true,
    bufferline = true,
    mason = true,
    linebar = true,
  },
})

vim.cmd.colorscheme("catppuccin")

-- vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
--
-- require("gruvbox").setup({
--   terminal_colors = true,
--   transparent_mode = true,
--
--   italic = {
--     strings = false,
--     emphasis = true,
--     comments = true,
--     operators = false,
--     folds = true,
--   },
--
--   overrides = {},
--
--   integrations = {
--     treesitter = true,
--     gitsigns = true,
--     fzf = true,
--     neo_tree = true,
--     which_key = true,
--     bufferline = true,
--     mason = true,
--     lualine = true,
--   },
-- })
--
-- vim.o.background = "dark"
-- vim.cmd.colorscheme("gruvbox")
