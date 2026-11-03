-- lua/plugins/theme.lua
-- vim.pack.add({ "https://github.com/catppuccin/nvim" })
--
-- require("catppuccin").setup({
--   flavour = "frappe",
--   transparent_background = true,
--   integrations = {
--     treesitter = true,
--     gitsigns = true,
--     fzf = true,
--     neo_tree = true,
--     which_key = true,
--     bufferline = true,
--     mason = true,
--     linebar = true,
--   },
-- })
--
-- vim.cmd.colorscheme("catppuccin")


vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })

require("gruvbox").setup({
  contrast = "",                -- "hard", "soft" or "" (default)
  transparent_mode = true,      -- equivalent of transparent_background
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  inverse = true,               -- invert background for search, diffs, statuslines
  dim_inactive = false,
  palette_overrides = {},
  overrides = {
    StatusLine = { bg = "NONE" },
    StatusLineNC = { bg = "NONE" },
    TabLine = { bg = "NONE" },
    TabLineFill = { bg = "NONE" },
    TabLineSel = { bg = "NONE" },
  },
})

vim.o.background = "dark"       -- or "light"
vim.cmd.colorscheme("gruvbox")
