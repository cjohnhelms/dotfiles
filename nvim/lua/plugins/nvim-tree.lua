return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    { "<leader>o", "<cmd>NvimTreeFocus<cr>", desc = "Focus file explorer" },
  },
  init = function()
    -- disable netrw at the very start
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  config = function()
    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true
    
    require("nvim-tree").setup({
      -- You can add custom options here
      -- view = {
      --   width = 30,
      -- },
      -- renderer = {
      --   group_empty = true,
      -- },
      -- filters = {
      --   dotfiles = false,
      -- },
    })
  end,
}
