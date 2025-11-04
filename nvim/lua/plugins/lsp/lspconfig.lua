local plugins = {}

local language_servers = {
  lua = "lua_ls",
  yaml = "yamlls",
  c = "clangd",
  cpp = "clangd",
  cmake = "neocmake",
  go = "gopls"
}

plugins = {
  {
    "stevearc/conform.nvim",
    ft = vim.tbl_keys(language_servers),
    opts = {
      formatters_by_ft = {
        go = { "gofumpt" }
      }
    },
    config = function (_, opts)
      local conform = require("conform")
      conform.setup(opts)
      vim.bo.formatexpr = "v:lua.require('conform').formatexpr()"
    end
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonUpdate", "MasonInstall" },
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig"
    },
    ft = vim.tbl_keys(language_servers),
    opts = {
      ensure_installed = { "lua_ls" },
      automatic_installation = false
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable(vim.tbl_values(language_servers))

      -- lsp-config
      -- vim.api.nvim_create_autocmd("BufEnter", {
      --   group = vim.api.nvim_create_augroup("LspEnable", {}),
      --   callback = function(args)
      --     local ft = vim.bo[args.buf].filetype
      --     if language_servers[ft] then
      --       vim.lsp.enable(language_servers[ft])
      --     end
      --   end
      -- })

      -- language server protocol feature
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspKeyMap", {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local opts = { buffer = args.buf }

          if client and client:supports_method('textDocument/documentSymbol') then
            vim.keymap.set('n', 'grs', vim.lsp.buf.document_symbol,
              vim.tbl_deep_extend("force", opts, { desc = "vim.lsp.buf.document_symbol()" }))
          end

          if client and client:supports_method('textDocument/inlay_hint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end

        end
      })

      -- foldexpr
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspFoldExpr", {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client ~= nil and client:supports_method('textDocument/foldingRange') then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
          end
        end
      })
    end
  }
}

return plugins
