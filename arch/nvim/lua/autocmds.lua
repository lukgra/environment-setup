local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name) return vim.api.nvim_create_augroup(name, { clear = true }) end

-- Highlight on yank
autocmd('TextYankPost', {
  group    = augroup 'highlight-yank',
  desc     = 'Highlight text on yank',
  callback = function() vim.hl.on_yank() end,
})

-- Resize splits when window is resized
autocmd('VimResized', {
  group    = augroup 'resize-splits',
  desc     = 'Equalize splits on resize',
  callback = function() vim.cmd 'tabdo wincmd =' end,
})

-- Go to last cursor position when opening a buffer
autocmd('BufReadPost', {
  group    = augroup 'last-cursor-position',
  desc     = 'Restore last cursor position',
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(ev.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Close certain filetypes with just 'q'
autocmd('FileType', {
  group   = augroup 'close-with-q',
  pattern = { 'help', 'lspinfo', 'man', 'notify', 'qf', 'checkhealth', 'startuptime' },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<CR>', { buffer = ev.buf, silent = true })
  end,
})

-- Auto-create missing directories on save
autocmd('BufWritePre', {
  group    = augroup 'auto-create-dir',
  desc     = 'Create parent directories on save',
  callback = function(ev)
    if ev.match:match '^%w%w+://' then return end
    local file = vim.uv.fs_realpath(ev.match) or ev.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Transparent floats + bufferline — reapply on colorscheme change
local transparent_hl = { 'NormalFloat', 'FloatBorder', 'NormalNC' }
local function apply_transparency()
  for _, hl in ipairs(transparent_hl) do
    vim.api.nvim_set_hl(0, hl, { bg = 'NONE' })
  end
  -- Strip background from all BufferLine highlight groups
  for _, hl in ipairs(vim.fn.getcompletion('BufferLine', 'highlight')) do
    local current = vim.api.nvim_get_hl(0, { name = hl, link = false })
    current.bg = nil
    current.ctermbg = nil
    vim.api.nvim_set_hl(0, hl, current)
  end
end

autocmd('ColorScheme', {
  group    = augroup 'transparent-floats',
  callback = apply_transparency,
})

-- Apply once on startup
apply_transparency()

-- Enable treesitter folding for supported filetypes
autocmd('FileType', {
  group    = augroup 'treesitter-fold',
  callback = function()
    local ok, _ = pcall(vim.treesitter.get_parser)
    if ok then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
    end
  end,
})
