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

  -- tree
  { "kyazdani42/nvim-tree.lua", dependencies = { "kyazdani42/nvim-web-devicons" } },

  -- treesitter
  { 
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },

  -- lsp
  { "neovim/nvim-lspconfig" },

  -- autocomplete
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Telescope help tags" })
	end,
  }

}

