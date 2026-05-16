local M = {}

M.configs = {
  lua_ls = {
    settings = {
      Lua = {
        completion = { callSnippet = "Replace" },
      },
    },
  },

  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "openFilesOnly",
          diagnosticSeverityOverrides = {
            reportGeneralTypeIssues = "warning",
            reportOptionalMemberAccess = "warning",
            reportOptionalSubscript = "warning",
            reportPrivateImportUsage = "warning",
          },
        },
      },
    },
  },

  gopls = {
    settings = {
      gopls = {
        analyses = { unusedparams = true },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },

  clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
  },

  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
      },
    },
  },

  ts_ls = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayFunctionParameterTypeHints = true,
        },
      },
    },
  },
}

-- mason-tool-installer will ensure all of these are present.
-- Auto-built from configs keys + extra formatters/linters.
M.tools = vim.tbl_keys(M.configs)
vim.list_extend(M.tools, {
  "stylua",
  "prettierd",
  "ruff",
  "shfmt",
  "shellcheck",
})

return M
