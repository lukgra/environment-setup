-- lua/plugins/theme.lua
vim.pack.add({ 'https://github.com/catppuccin/nvim' })

require('catppuccin').setup({
  flavour                = 'mocha',
  transparent_background = true,
  integrations = {
    treesitter  = true,
    gitsigns    = true,
    fzf         = true,
    neo_tree    = true,
    which_key   = true,
    bufferline  = true,
    mason       = true,
  },
})

vim.cmd.colorscheme 'catppuccin'

