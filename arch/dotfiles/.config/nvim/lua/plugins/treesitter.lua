-- lua/plugins/treesitter.lua
-- Requires: brew install tree-sitter-cli
vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("treesitter-pack", { clear = true }),
  callback = function(ev)
    if ev.data.kind == "update" then
      pcall(vim.cmd, "TSUpdate")
    end
  end,
})

require("nvim-treesitter").setup({})
require("nvim-treesitter").install({
  "bash",
  "c",
  "css",
  "diff",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
})

require("nvim-treesitter-textobjects").setup({
  select = {
    enable = true,
    lookahead = true,
    selection_modes = {
      ["@parameter.outer"] = "v",
      ["@function.outer"] = "V",
      ["@class.outer"] = "<c-v>",
    },
  },
  move = { enable = true, set_jumps = true },
})

-- Textobject keymaps
local sel = require("nvim-treesitter-textobjects.select")
local mv = require("nvim-treesitter-textobjects.move")
local map = vim.keymap.set

for _, t in ipairs({
  { "af", "@function.outer", "outer function" },
  { "if", "@function.inner", "inner function" },
  { "ac", "@class.outer", "outer class" },
  { "ic", "@class.inner", "inner class" },
}) do
  map({ "x", "o" }, t[1], function()
    sel.select_textobject(t[2], "textobjects")
  end, { desc = t[3] })
end

for _, t in ipairs({
  { "]f", "next", "@function.outer", "Next function" },
  { "[f", "prev", "@function.outer", "Prev function" },
  { "]c", "next", "@class.outer", "Next class" },
  { "[c", "prev", "@class.outer", "Prev class" },
}) do
  local fn = t[2] == "next" and mv.goto_next_start or mv.goto_previous_start
  map({ "n", "x", "o" }, t[1], function()
    fn(t[3], "textobjects")
  end, { desc = t[4] })
end

-- Enable highlighting, folding, indentation per buffer
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-attach", { clear = true }),
  callback = function()
    local ok = pcall(vim.treesitter.start)
    if ok then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
