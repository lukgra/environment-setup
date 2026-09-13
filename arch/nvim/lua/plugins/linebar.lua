-- lua/plugins/linebar.lua
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

require("lualine").setup({
  options = {
    theme = "catppuccin-mocha",
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
