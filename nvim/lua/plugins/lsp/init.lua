vim.lsp.config('*', vim.lsp.protocol.make_client_capabilities())

local plugins = {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    }
  }
}

local lspconfig = require("plugins.lsp.lspconfig")

plugins = vim.list_extend(
  plugins,
  lspconfig)

return plugins
