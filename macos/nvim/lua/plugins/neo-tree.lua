-- lua/plugins/neo-tree.lua
vim.pack.add({
  "https://github.com/nvim-neo-tree/neo-tree.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/MunifTanjim/nui.nvim",
})

require("neo-tree").setup({
  close_if_last_window = true,
  window = { width = 30 },
  filesystem = {
    follow_current_file = { enabled = true },
    hijack_netrw_behavior = "open_current",
    filtered_items = { hide_dotfiles = false, hide_gitignored = true },
    window = {
      mappings = {
        ["\\"] = "close_window",
        ["<space>"] = "open",
      },
    },
  },
})

vim.keymap.set("n", "\\", "<cmd>Neotree reveal<CR>", { desc = "Neotree reveal", silent = true })
