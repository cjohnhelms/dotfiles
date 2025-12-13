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

  -- mason
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
	  ensure_installed = { "gopls" },
	},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
  },

  -- lsp
  { "neovim/nvim-lspconfig" },

  -- autocomplete
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },

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
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
    }
  },
}

