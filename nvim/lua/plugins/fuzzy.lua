local fzf_keybinding = function()
  -- lsp
  vim.keymap.set("n", "<leader>f",
    "<cmd>FzfLua<CR>",
    {
      silent = true,
      desc = "Open FzfLua floating window",
    })
  vim.keymap.set("n", "<leader><C-p>",
    "<cmd>lua require('fzf-lua').files()<CR>",
    {
      silent = true,
      desc = "Go to File",
    })
  vim.keymap.set("n", "<leader><C-t>",
    "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols()<CR>",
    {
      silent = true,
      desc = "Go to Symbol in Workspace",
    })
end


return {
  {
    "ibhagwan/fzf-lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
      fzf_keybinding()
    end,
    cmd = { "FzfLua" },
    opts = {},
  },
}
