-- lua/plugins/fzf.lua
vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

require("fzf-lua").setup({
  "default-title",
  winopts = {
    backdrop = 100,
    height = 0.85,
    width = 0.80,
    row = 0.35,
    col = 0.50,
    border = "rounded",
    preview = {
      layout = "flex",
      flip_columns = 120,
      scrollbar = "float",
    },
  },
  files = {
    prompt = "Files❯ ",
    multiprocess = true,
    git_icons = true,
    file_icons = true,
    color_icons = true,
    cmd = 'rg --files --hidden --follow -g "!.git"',
  },
  grep = {
    prompt = "Rg❯ ",
    input_prompt = "Grep For❯ ",
    multiprocess = true,
    git_icons = true,
    file_icons = true,
    color_icons = true,
  },
  lsp = {
    prompt_postfix = "❯ ",
    symbols = {
      symbol_icons = {
        File = "",
        Module = "",
        Namespace = "",
        Package = "",
        Class = "",
        Method = "",
        Property = "",
        Field = "",
        Constructor = "",
        Enum = "",
        Interface = "",
        Function = "",
        Variable = "",
        Constant = "",
        String = "",
        Number = "",
        Boolean = "",
        Array = "",
        Object = "",
        Key = "",
        Null = "",
      },
    },
  },
  previewers = {
    builtin = {
      syntax = true,
      syntax_limit_b = 1024 * 100,
    },
  },
})

local map = vim.keymap.set
local fzf = require("fzf-lua")

-- Files
map("n", "<leader>sf", fzf.files, { desc = "Search Files" })
map("n", "<leader>sg", fzf.live_grep, { desc = "Search by Grep" })
map("n", "<leader>sw", fzf.grep_cword, { desc = "Search Word under cursor" })
map("n", "<leader>sb", fzf.buffers, { desc = "Search Buffers" })
map("n", "<leader>sh", fzf.help_tags, { desc = "Search Help" })
map("n", "<leader>so", fzf.oldfiles, { desc = "Search Old files" })
map("n", "<leader>sc", fzf.commands, { desc = "Search Commands" })
map("n", "<leader>sk", fzf.keymaps, { desc = "Search Keymaps" })
map("n", "<leader>sr", fzf.resume, { desc = "Resume last search" })

-- Git
map("n", "<leader>gf", fzf.git_files, { desc = "Git Files" })
map("n", "<leader>gc", fzf.git_commits, { desc = "Git Commits" })
map("n", "<leader>gs", fzf.git_status, { desc = "Git Status" })
