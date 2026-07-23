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

vim.opt.cmdheight = 0

vim.diagnostic.config({ virtual_text = true })
vim.o.winborder = "rounded"

-- ===========================
-- Leader Key
-- ===========================
vim.g.mapleader = ","

-- ===========================
-- Keymaps
-- ===========================
vim.keymap.set("n", "<leader>bn", ":bnext<CR>",     { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>",   { silent = true, desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bf", ":Telescope buffers<CR>", { silent = true, desc = "Find buffer" })

vim.keymap.set("n", "<leader>wh", "<C-w>h", { silent = true, desc = "Focus left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { silent = true, desc = "Focus down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { silent = true, desc = "Focus up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { silent = true, desc = "Focus right" })

-- ===========================
-- Format on Save
-- ===========================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local input = table.concat(lines, "\n")
    local style = "{BasedOnStyle: LLVM, IndentWidth: 8, UseTab: Always, TabWidth: 8, BreakBeforeBraces: Linux, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 80}"
    local result = vim.fn.system("clang-format --style=" .. vim.fn.shellescape(style), input)
    if vim.v.shell_error == 0 then
      local new_lines = vim.split(result, "\n", { plain = true })
      if new_lines[#new_lines] == "" then
        table.remove(new_lines)
      end
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
    end
  end,
})

vim.opt.cursorline = true
vim.opt.relativenumber = true

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { silent = true, desc = "Exit terminal insert mode" })

vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float, { silent = true, desc = "Show diagnostics" })
