return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('fzf-lua').setup {
      -- Default preset
      'default-title',

      winopts = {
        backdrop = 100,
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = 'rounded',
        preview = {
          layout = 'flex',
          flip_columns = 120,
          scrollbar = 'float',
        },
      },

      -- File picker settings
      files = {
        prompt = 'Files❯ ',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
        -- .gitignore
        cmd = 'rg --files --hidden --follow -g "!.git"',
      },

      -- Grep settings
      grep = {
        prompt = 'Rg❯ ',
        input_prompt = 'Grep For❯ ',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },

      -- LSP settings
      lsp = {
        prompt_postfix = '❯ ',
        symbols = {
          symbol_icons = {
            File = '',
            Module = '',
            Namespace = '',
            Package = '',
            Class = '',
            Method = '',
            Property = '',
            Field = '',
            Constructor = '',
            Enum = '',
            Interface = '',
            Function = '',
            Variable = '',
            Constant = '',
            String = '',
            Number = '',
            Boolean = '',
            Array = '',
            Object = '',
            Key = '',
            Null = '',
          },
        },
      },

      -- Preview window settings
      previewers = {
        builtin = {
          syntax = true,
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
    }

    -- Keymaps
    local fzf = require 'fzf-lua'

    -- File finding
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = 'Search Files' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = 'Search by Grep' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = 'Search Word under cursor' })
    vim.keymap.set('n', '<leader>sb', fzf.buffers, { desc = 'Search Buffers' })
    vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>so', fzf.oldfiles, { desc = 'Search Old files' })
    vim.keymap.set('n', '<leader>sc', fzf.commands, { desc = 'Search Commands' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = 'Search Keymaps' })

    -- Git
    vim.keymap.set('n', '<leader>gf', fzf.git_files, { desc = 'Git Files' })
    vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = 'Git Commits' })
    vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = 'Git Status' })

    -- LSP (if you use LSP)
    vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = 'LSP References' })
    vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = 'LSP Definitions' })
    vim.keymap.set('n', '<leader>ds', fzf.lsp_document_symbols, { desc = 'Document Symbols' })
    vim.keymap.set('n', '<leader>ws', fzf.lsp_workspace_symbols, { desc = 'Workspace Symbols' })

    -- Resume last search
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = 'Resume last search' })
  end,
}
