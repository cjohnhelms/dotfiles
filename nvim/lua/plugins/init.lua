-- plugins.lua
return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,           -- load during startup
    priority = 1000,        -- make sure it loads before other UI plugins
    config = function()
      vim.cmd("colorscheme vscode")
    end,
  },

    -- Import plugin configs
  { import = "plugins.lspconfig" },
  { import = "plugins.blink" },
  { import = "plugins.nvim-tree" },
  { import = "plugins.treesitter" },
  { import = "plugins.telescope" },
  { import = "plugins.which-key" },
  { import = "plugins.lualine" },
  { import = "plugins.mason" },
  { import = "plugins.mason-lspconfig" },

}

