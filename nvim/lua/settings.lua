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
vim.opt.signcolumn = "yes"

vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = "rounded"

-- ===========================
-- Leader Key
-- ===========================
vim.g.mapleader = ","

-- ===========================
-- Keymaps
-- ===========================
vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })
