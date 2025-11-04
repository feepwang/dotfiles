local plugins = {}

plugins = {
  {
    "mfussenegger/nvim-dap",
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    ft = { "c", "cpp", "go" }
  }
}

return plugins
