-- NeoVim config --

-- [GLOBAL] --

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd font
vim.g.have_nerd_font = true

-- [OPTIONS] --

-- Make line numbers default
vim.o.number = true

-- Relative line numbers
vim.o.relativenumber = true

-- Hide ~ sign on empty lines
vim.opt.fillchars:append { eob = ' ' }

-- Enable mouse mode
vim.o.mouse = 'a'

-- Hide mode (displayed in status line)
vim.o.showmode = false

-- Sync clipboard between Neovim and OS
-- runs after the init file
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default (space for plugin info on the right)
vim.o.signcolumn = 'yes'

-- Decrease update time (cursor hold event trigger)
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets whitespace characters display format
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- -- Global Indentation Settings (NOTSURE ABOUT THIS)
vim.opt.tabstop = 2      -- A tab character will be 4 spaces wide
vim.opt.shiftwidth = 2   -- The number of spaces to use for auto-indent
vim.opt.softtabstop = 2  -- When you press tab, it acts like 4 spaces
vim.opt.expandtab = true -- Use spaces instead of tab characters

-- Preview substitutions live while typing (usefull for commands preview)
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Raise dialog on failed operation due to unsaved changes
vim.o.confirm = true

-- [BASIC KEYMAPS] --

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- NOTE: This won't work in all terminal emulators/tmux/etc
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [Basic Autocommands] --

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [Lazyvim Plugin Manager] --

-- install
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [Plugins] --
local plugins = {
  -- Indentation guessing
  require 'plugins.guess-indent',

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  require 'plugins.gitsigns',

  -- Useful plugin to show you pending keybinds.
  require 'plugins.which-key',

  -- Fuzzy finder for files
  require 'plugins.fzf',

  -- LSP Plugins
  require 'plugins.lsp',

  -- Autocompletion
  require 'plugins.autocompletion',

  -- Highligting and more
  require 'plugins.editor',

  -- File explorer
  require 'plugins.neo-tree',

  -- Formatting on save and linting
  require 'plugins.formatting',

  -- Buffer managment
  require 'plugins.buffers',

  -- Prettier linebar
  require 'plugins.linebar',

  -- Popup messages
  require 'plugins.noice',

  -- Theme
  require 'plugins.theme',
}

require('lazy').setup(plugins, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = ':🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- [Appearence] --

-- Set transparency for all floating windows
local transparent_hl = {
  'NormalFloat',
  'FloatBorder',
  'NormalNC',
}

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    for _, hl in ipairs(transparent_hl) do
      vim.api.nvim_set_hl(0, hl, { bg = 'NONE' })
    end
  end,
})

-- Apply on startup
for _, hl in ipairs(transparent_hl) do
  vim.api.nvim_set_hl(0, hl, { bg = 'NONE' })
end
