return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- Lazy load on opening files
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects", -- Optional but recommended
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = { "yaml", "json", "go", "rust", "ocaml", "python" },
      highlight = { enable = true },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
    })
  end,
}
