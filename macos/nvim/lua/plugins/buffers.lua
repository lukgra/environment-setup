-- lua/plugins/buffers.lua
vim.pack.add({
  "https://github.com/akinsho/bufferline.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/famiu/bufdelete.nvim",
})

local function is_placeholder(buf)
  return vim.api.nvim_buf_is_valid(buf)
    and vim.bo[buf].buftype == ""
    and vim.api.nvim_buf_get_name(buf) == ""
    and not vim.bo[buf].modified
    and vim.api.nvim_buf_line_count(buf) <= 1
    and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ""
end

local function new_placeholder()
  vim.cmd("enew")
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
end

vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("wipe-placeholder-buffers", { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "" or vim.api.nvim_buf_get_name(ev.buf) == "" then
      return
    end
    vim.schedule(function()
      for _, b in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
        if #b.windows == 0 and is_placeholder(b.bufnr) then
          pcall(vim.api.nvim_buf_delete, b.bufnr, {})
        end
      end
    end)
  end,
})

require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    separator_style = "thin",

    custom_filter = function(buf)
      return not is_placeholder(buf)
    end,

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

local function strip_bufferline_bg()
  for _, hl in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
    local current = vim.api.nvim_get_hl(0, { name = hl, link = false })
    current.bg = nil
    current.ctermbg = nil
    vim.api.nvim_set_hl(0, hl, current)
  end
end
strip_bufferline_bg()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("bufferline-transparent", { clear = true }),
  callback = function()
    vim.schedule(strip_bufferline_bg)
  end,
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
  local cur = vim.api.nvim_get_current_buf()
  if is_placeholder(cur) then
    return
  end
  if #bufs <= 1 then
    new_placeholder()
  end
  require("bufdelete").bufdelete(cur, true)
end, { desc = "Delete buffer" })
map("n", "<leader>abd", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs == 0 then
    return
  end
  new_placeholder()
  for _, buf in ipairs(bufs) do
    require("bufdelete").bufdelete(buf.bufnr, true)
  end
end, { desc = "Delete all buffers" })
