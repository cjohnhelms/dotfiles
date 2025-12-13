return {
  "mason-org/mason-lspconfig.nvim",
  opts = {
    ensure_installed = { "gopls" },
  },
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
}
