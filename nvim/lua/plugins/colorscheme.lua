vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.opt.fillchars = { vert = " " }
    vim.api.nvim_set_hl(0, "WinSeparator", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { link = "Normal" })
  end,
})

return {
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("vscode")
    end,
  },
  { "projekt0n/github-nvim-theme", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "folke/tokyonight.nvim", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
}
