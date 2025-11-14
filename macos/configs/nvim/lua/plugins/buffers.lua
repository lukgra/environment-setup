return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',

        -- Style
        separator_style = 'thin',

        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },

        -- indicator = {
        --   icon = '▎',
        --   style = 'icon',
        -- },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',

        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 20,

        -- Behavior
        close_command = 'bdelete! %d',
        right_mouse_command = 'bdelete! %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = nil,

        -- Diagnostics integration
        diagnostics = 'nvim_lsp',
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,

        -- File tree offset
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Neo-tree',
            text_align = 'center',
            separator = true,
          },
        },

        -- Icons and appearance
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,

        -- Sorting
        sort_by = 'insert_after_current',
      },
    }
    -- PRIMARY NAVIGATION: Switch between buffers
    vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true, desc = 'Next buffer' })
    vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true, desc = 'Previous buffer' })

    -- Jump to specific buffer by number (Ctrl+1-9)
    for i = 1, 9 do
      vim.keymap.set('n', '<C-' .. i .. '>', ':BufferLineGoToBuffer ' .. i .. '<CR>', { silent = true, desc = 'Go to buffer ' .. i })
    end

    -- Reorder buffers (move them left/right in the bar)
    vim.keymap.set('n', '<C-,>', ':BufferLineMovePrev<CR>', { silent = true, desc = 'Move buffer left' })
    vim.keymap.set('n', '<C-.>', ':BufferLineMoveNext<CR>', { silent = true, desc = 'Move buffer right' })

    -- Close buffer
    vim.keymap.set('n', '<S-x>', ':bd<CR>', { silent = true, desc = 'Close buffer' })
  end,
}
