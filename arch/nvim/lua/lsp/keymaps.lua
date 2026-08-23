local M = {}

function M.attach(bufnr)
  local map = function(keys, fn, desc, mode)
    vim.keymap.set(mode or "n", keys, fn, { buffer = bufnr, desc = "LSP: " .. desc })
  end

  local b = vim.lsp.buf
  local fzf = require("fzf-lua")

  -- Navigation
  map("gd", fzf.lsp_definitions, "Go to Definition")
  map("gD", b.declaration, "Go to Declaration")
  map("gr", fzf.lsp_references, "Go to References")
  map("gI", fzf.lsp_implementations, "Go to Implementation")
  map("gy", fzf.lsp_typedefs, "Go to Type Definition")

  -- Info
  map("K", b.hover, "Hover Docs")
  map("<leader>ds", fzf.lsp_document_symbols, "Document Symbols")
  map("<leader>ws", fzf.lsp_workspace_symbols, "Workspace Symbols")

  -- Actions
  map("<leader>rn", b.rename, "Rename")
  map("<leader>ca", b.code_action, "Code Action", { "n", "v" })

  -- Inlay hints toggle
  map("<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, "Toggle Inlay Hints")
end

return M
