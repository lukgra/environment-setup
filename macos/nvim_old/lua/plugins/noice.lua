return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('notify').setup {
        background_colour = '#1e1e2e',
        max_width = 40,
        max_height = 10,
      }

      require('noice').setup {
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
        },
        views = {
          cmdline_popup = {
            position = {
              row = '50%',
              col = '50%',
            },
            size = {
              width = 60,
              height = 'auto',
            },
            border = {
              style = 'rounded',
              padding = { 1, 2 },
            },
            win_options = {
              winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
              winblend = 0,
            },
          },
          popupmenu = {
            relative = 'editor',
            position = {
              row = '50%',
              col = '50%',
            },
            size = {
              width = 60,
              height = 'auto',
            },
            border = {
              style = 'rounded',
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
              winblend = 0,
            },
          },
        },
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
          hover = {
            enabled = true,
          },
          signature = {
            enabled = true,
          },
        },
        presets = {
          bottom_search = false,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = true,
        },
        notify = {
          enabled = true,
          view = 'notify',
        },
        messages = {
          enabled = true,
          view = 'notify',
          view_error = 'notify',
          view_warn = 'notify',
          view_history = 'messages',
          view_search = 'virtualtext',
        },
      }
    end,
  },
}
