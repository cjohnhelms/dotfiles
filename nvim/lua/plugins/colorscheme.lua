return {
  "projekt0n/github-nvim-theme",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("github_dark")
    vim.opt.fillchars = { vert = " " }
    vim.api.nvim_set_hl(0, "WinSeparator", { link = "Normal" })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { link = "Normal" })
  end,
}
