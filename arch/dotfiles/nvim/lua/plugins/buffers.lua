return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>',            desc = 'Toggle Pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    { '<Tab>',      '<cmd>BufferLineCycleNext<cr>',            desc = 'Next Buffer' },
    { '<S-Tab>',    '<cmd>BufferLineCyclePrev<cr>',            desc = 'Prev Buffer' },
    { '<leader>,',  '<Cmd>BufferLineMovePrev<CR>',             desc = 'Move buffer left' },
    { '<leader>.',  '<Cmd>BufferLineMoveNext<CR>',             desc = 'Move buffer right' },
  },

  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'famiu/bufdelete.nvim',
  },
  opts = {
    options = {
      left_mouse_command = function(bufnum)
        local lazy = require 'bufferline.lazy'
        local ui = lazy.require 'bufferline.ui'
        local windows = vim.fn.win_findbuf(bufnum)
        if windows[1] then
          vim.api.nvim_set_current_win(windows[1])
        end
        vim.schedule(function()
          vim.cmd(string.format('buffer %d', bufnum))
          ui.refresh()
        end)
      end,
      close_command = function(bufnum)
        require('bufdelete').bufdelete(bufnum, true)
      end,
      right_mouse_command = function(bufnum)
        require('bufdelete').bufdelete(bufnum, true)
      end,
      diagnostics = 'nvim_lsp',
      always_show_bufferline = false,
      diagnostics_indicator = function(_, _, diag)
        local ret = (diag.error and ' ' .. diag.error .. ' ' or '') .. (diag.warning and ' ' .. diag.warning or '')
        return vim.trim(ret)
      end,
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-tree',
          highlight = 'Directory',
          text_align = 'left',
        },
      },
    },
  },
}
