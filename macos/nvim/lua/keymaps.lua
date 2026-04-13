local map = vim.keymap.set

-- Basics
map('n', '<Esc>',      '<cmd>nohlsearch<CR>',            { desc = 'Clear search highlights' })
map('n', '<leader>q',  vim.diagnostic.setloclist,        { desc = 'Quickfix diagnostics' })
map('t', '<Esc><Esc>', '<C-\\><C-n>',                    { desc = 'Exit terminal mode' })

-- Window navigation
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })

-- Better line movement on wrapped lines
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down (wrapped)' })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up (wrapped)' })

-- Stay in indent mode when indenting
map('v', '<', '<gv', { desc = 'Indent left' })
map('v', '>', '>gv', { desc = 'Indent right' })

-- Move lines up/down
map('n', '<A-j>', '<cmd>m .+1<CR>==',  { desc = 'Move line down' })
map('n', '<A-k>', '<cmd>m .-2<CR>==',  { desc = 'Move line up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Diagnostics
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
map('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show diagnostic error' })

-- Quickfix navigation
map('n', '[q', '<cmd>cprev<CR>', { desc = 'Prev quickfix' })
map('n', ']q', '<cmd>cnext<CR>', { desc = 'Next quickfix' })

-- Plugin management
map('n', '<leader>pu', '<cmd>lua vim.pack.update()<CR>', { desc = 'Update plugins' })

-- Buffer navigation (used with bufferline)
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Prev buffer' })
map('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>',        { desc = 'Delete buffer' })

-- File explorer
map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { desc = 'Toggle explorer' })
map('n', '<leader>E', '<cmd>Neotree reveal<CR>', { desc = 'Reveal in explorer' })

-- Formatting
map({ 'n', 'v' }, '<leader>f', function()
  require('conform').format({ async = true, lsp_format = 'fallback' })
end, { desc = 'Format buffer' })
