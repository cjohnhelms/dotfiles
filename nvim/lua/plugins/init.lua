-- plugins.lua
return {
  {
	"oskarnurm/koda.nvim",
  	lazy = false, -- make sure we load this during startup if it is your main colorscheme
  	priority = 1000, -- make sure to load this before all the other start plugins
  	config = function()
  	  -- require("koda").setup({ transparent = true })
  	  vim.cmd("colorscheme koda")
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

