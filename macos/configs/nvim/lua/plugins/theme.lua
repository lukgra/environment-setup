return {
  -- {
  --   dir = '~/.config/nvim/lua/themes/akane',
  --   priority = 1000,
  --   config = function()
  --     require('themes.akane').setup()
  --   end,
  -- },
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   config = function()
  --     ---@diagnostic disable-next-line: missing-fields
  --     require('tokyonight').setup {
  --       styles = {
  --         comments = { italic = false }, -- Disable italics in comments
  --       },
  --     }
  --     -- vim.cmd.colorscheme 'tokyonight-moon'
  --   end,
  -- },
  {
    'vague-theme/vague.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      -- require('tokyonight').setup {
      --   styles = {
      --     comments = { italic = false }, -- Disable italics in comments
      --   },
      -- }
      vim.cmd.colorscheme 'vague'
    end,
  },
}
