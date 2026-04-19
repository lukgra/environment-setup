-- Leaders (must be set before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local o = vim.o
local opt = vim.opt

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.showmode = false
o.laststatus = 3 -- global statusline
o.cmdheight = 1
o.scrolloff = 10
o.splitright = true
o.splitbelow = true
o.winborder = "rounded" -- 0.12: native rounded borders everywhere

-- Folding
o.foldcolumn = "auto"
o.foldlevelstart = 99
vim.wo.foldtext = "" -- use treesitter fold text

-- Fill chars
opt.fillchars = {
  eob = " ",
  fold = " ",
  foldsep = " ",
  foldopen = "▾",
  foldclose = "▸",
  msgsep = "─",
}

-- Whitespace display
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Indentation (guess-indent will override per buffer)
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.breakindent = true

-- Search
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

-- Completion
o.completeopt = "menuone,noselect,noinsert"
o.pumheight = 15
o.pumborder = "rounded"
o.autocomplete = true -- 0.12 native insert-mode completion

-- Behaviour
o.mouse = "a"
o.confirm = true
o.undofile = true
o.updatetime = 250
o.timeoutlen = 300
o.exrc = true -- allow project-local .nvim.lua configs

-- Clipboard (deferred to avoid startup slowdown)
vim.schedule(function()
  o.clipboard = "unnamedplus"
end)

-- Spelling
opt.spell = true
opt.spelllang = { "en_us" }

-- Suppress noisy short messages
opt.shortmess:append({ s = true, w = true })

-- Diff
opt.diffopt:append("vertical,context:99")

-- Ignore in wildmenu
opt.wildignore:append({ ".DS_Store", "*.o", "*.pyc" })
