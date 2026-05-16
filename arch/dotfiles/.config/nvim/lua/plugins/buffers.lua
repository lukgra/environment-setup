-- lua/plugins/buffers.lua
vim.pack.add({
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/famiu/bufdelete.nvim",
})

require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    separator_style = "thin",
    close_command = function(n)
      require("bufdelete").bufdelete(n, true)
    end,
    right_mouse_command = function(n)
      require("bufdelete").bufdelete(n, true)
    end,
    diagnostics_indicator = function(_, _, diag)
      local ret = (diag.error and " " .. diag.error .. " " or "") .. (diag.warning and " " .. diag.warning or "")
      return vim.trim(ret)
    end,
    offsets = {
      { filetype = "neo-tree", text = "Neo-tree", highlight = "Directory", text_align = "left" },
    },
  },
})

local map = vim.keymap.set
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>,", "<cmd>BufferLineMovePrev<CR>", { desc = "Move buffer left" })
map("n", "<leader>.", "<cmd>BufferLineMoveNext<CR>", { desc = "Move buffer right" })
map("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle pin" })
map("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete non-pinned buffers" })
map("n", "<leader>bd", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  local cur = vim.api.nvim_get_current_buf() -- capture BEFORE enew
  if #bufs <= 1 then
    vim.cmd("enew")
  end
  require("bufdelete").bufdelete(cur, true) -- delete the original
end, { desc = "Delete buffer" })
map("n", "<leader>abd", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs == 0 then
    return
  end

  vim.cmd("enew") -- open a clean buffer so windows have somewhere to land
  for _, buf in ipairs(bufs) do
    require("bufdelete").bufdelete(buf.bufnr, true)
  end
end, { desc = "Delete all buffers" })
