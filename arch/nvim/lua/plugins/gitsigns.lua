-- lua/plugins/gitsigns.lua
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = function(l, r, desc)
      vim.keymap.set("n", l, r, { buffer = bufnr, desc = "Git: " .. desc })
    end
    map("]h", gs.next_hunk, "Next hunk")
    map("[h", gs.prev_hunk, "Prev hunk")
    map("<leader>hs", gs.stage_hunk, "Stage hunk")
    map("<leader>hr", gs.reset_hunk, "Reset hunk")
    map("<leader>hS", gs.stage_buffer, "Stage buffer")
    map("<leader>hp", gs.preview_hunk, "Preview hunk")
    map("<leader>hb", gs.blame_line, "Blame line")
    map("<leader>hd", gs.diffthis, "Diff this")
    map("<leader>hD", function()
      gs.diffthis("~")
    end, "Diff this ~")
  end,
})
