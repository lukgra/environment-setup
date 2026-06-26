-- lua/lsp.lua
-- LSP entry point. Server configs in lua/lsp/servers.lua, keymaps in lua/lsp/keymaps.lua.
-- On first launch vim.pack.add will install plugins; restart nvim after initial install.

vim.pack.add({
  "https://github.com/folke/lazydev.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  "https://github.com/saghen/blink.cmp",
  "https://github.com/j-hui/fidget.nvim",
})

-- Lua dev annotations — only activates in lua files
require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

-- LSP progress notifications
require("fidget").setup()

-- Blink completion
require("blink.cmp").setup({
  keymap = { preset = "default" },
  appearance = { use_nvim_cmp_as_default = true },
  signature = { enabled = true },
  fuzzy = { implementation = "lua" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    per_filetype = {
      lua = { inherit_defaults = true, "lazydev" },
    },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
})

-- Diagnostic display
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = { source = "if_many", spacing = 2 },
})

-- LspAttach: keymaps + document highlight + inlay hints
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    require("lsp.keymaps").attach(ev.buf)

    if client and client:supports_method("textDocument/documentHighlight", ev.buf) then
      local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = ev.buf,
        group = group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = ev.buf,
        group = group,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(ev2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = ev2.buf })
        end,
      })
    end

    if client and client:supports_method("textDocument/inlayHint", ev.buf) then
      vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
    end
  end,
})

-- Mason + lspconfig
require("mason").setup({ ui = { border = "rounded" } })

local servers = require("lsp.servers")
local capabilities = require("blink.cmp").get_lsp_capabilities()

require("mason-tool-installer").setup({ ensure_installed = servers.tools })

require("mason-lspconfig").setup({
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function(name)
      local cfg = servers.configs[name] or {}
      cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
      require("lspconfig")[name].setup(cfg)
    end,
  },
})

vim.filetype.add({
  extension = {
    j2 = "jinja",
  },
})
