return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
  },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
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
	  filters = {
        -- Set to false so that dotfiles like .env are always visible by default
	    dotfiles = false, 
      },
      git = {
        enable = true,
        -- Set to false if your .env is in .gitignore but you still want to see it
        ignore = false, 
      },
    })
  end,
}
