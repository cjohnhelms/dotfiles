-- ===========================
-- General Settings
-- ===========================
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.encoding = "utf-8"

vim.opt.scrolloff = 7
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.fileformat = "unix"

vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = "rounded"

-- ===========================
-- Leader Key
-- ===========================
vim.g.mapleader = ","

-- ===========================
-- Keymaps
-- ===========================
vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

-- ===========================
-- Bootstrap lazy.nvim
-- ===========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ===========================
-- lazy.nvim Setup
-- ===========================
require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})

-- ===========================
-- Load User Config Modules
-- ===========================
require("tree")
require("lsp")
require("treesitter")

