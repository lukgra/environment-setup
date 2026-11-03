-- lua/plugins/linebar.lua
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local theme = require("lualine.themes.gruvbox")
for _, mode in pairs(theme) do
  for _, section in ipairs({ "b", "c", "x", "y" }) do
    if mode[section] then
      mode[section].bg = "NONE"
    end
  end
end

require("lualine").setup({
  options = {
    theme = theme,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    globalstatus = true,
    disabled_filetypes = { statusline = { "neo-tree" } },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      {
        function()
          local clients = vim.lsp.get_clients({ bufnr = 0 })
          if #clients == 0 then
            return ""
          end
          return "󰒋 "
            .. table.concat(
              vim.tbl_map(function(c)
                return c.name
              end, clients),
              ", "
            )
        end,
        color = { fg = "#a6e3a1" },
      },
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
