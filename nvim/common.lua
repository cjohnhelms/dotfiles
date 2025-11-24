-- general
vim.opt.number = true
vim.g.mouse = 'a'
vim.opt.encoding="utf-8"

vim.opt.scrolloff = 7
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true

vim.opt.fileformat = "unix"

-- lsp
vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = "rounded" -- or "single", "double", "shadow", "none"

-- theme
vim.cmd.colorscheme("vscode")

-- leader
vim.g.mapleader = " "

-- keymaps
vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>h", "<C-w>h", { silent = true })
vim.keymap.set("n", "<leader>j", "<C-w>j", { silent = true })
vim.keymap.set("n", "<leader>k", "<C-w>k", { silent = true })
vim.keymap.set("n", "<leader>l", "<C-w>l", { silent = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
