local plugins = {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {}
  }
}

local cmp = require("plugins.edit.cmp")
plugins = vim.list_extend(vim.list_extend(plugins, {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {}
  }
}), cmp.plugins)

return plugins
