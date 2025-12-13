return {
  "folke/which-key.nvim",
  event = "VeryLazy", -- Load after startup for better performance
  config = function()
    local wk = require('which-key')
    
    -- Setup which-key
    wk.setup({
      preset = "modern",
      delay = 500,
      icons = {
        mappings = true,
        keys = {},
      },
    })
    
    -- Register key groups and mappings
    wk.add({
      { "<leader>f", group = "Find (Telescope)" },
      { "<leader>w", group = "Workspace" },
      { "<leader>c", group = "Code" },
      { "<leader>r", group = "Rename" },
      { "<leader>q", group = "Diagnostics" },
      { "<leader>g", group = "Git" },
      { "[", group = "Previous" },
      { "]", group = "Next" },
    })
  end,
}
