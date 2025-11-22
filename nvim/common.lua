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

-- theme
vim.cmd.colorscheme("vscode")

-- keymaps
vim.api.nvim_set_keymap('n', 't', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
