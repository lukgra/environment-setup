return {
  'voldikss/vim-floaterm',
  config = function()
    -- FloatTerm configuration
    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_position = 'center'
    vim.g.floaterm_borderchars = '─│─│╭╮╯╰'

    -- Keymaps
    local opts = { noremap = true, silent = true }

    -- Toggle terminal
    vim.keymap.set('n', '<leader>tt', ':FloatermToggle<CR>', opts)
    vim.keymap.set('t', '<leader>tt', '<C-\\><C-n>:FloatermToggle<CR>', opts)

    -- Create new terminal
    vim.keymap.set('n', '<leader>tn', ':FloatermNew<CR>', opts)

    -- Navigate between terminals
    vim.keymap.set('n', '<leader>t]', ':FloatermNext<CR>', opts)
    vim.keymap.set('n', '<leader>t[', ':FloatermPrev<CR>', opts)

    -- Kill current terminal
    vim.keymap.set('n', '<leader>tk', ':FloatermKill<CR>', opts)
  end,
}
