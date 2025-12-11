-- ===========================
-- Setup nvim-cmp
-- ===========================
local cmp = require('cmp')

cmp.setup({
  completion = {
    completeopt = "menu,menuone,noinsert"
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
  }, {
    { name = 'buffer' },
  })
})

-- ===========================
-- Get LSP capabilities for autocompletion
-- ===========================
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- ===========================
-- LSP Keymaps
-- ===========================
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap=true, silent=true, desc = "Show diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true, desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true, desc = "Next diagnostic" })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap=true, silent=true, desc = "Diagnostic list" })

-- ===========================
-- on_attach function
-- ===========================
local on_attach = function(client, bufnr)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', bufopts, { desc = "Go to declaration" }))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', bufopts, { desc = "Go to definition" }))
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', bufopts, { desc = "Hover documentation" }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', bufopts, { desc = "Go to implementation" }))
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, vim.tbl_extend('force', bufopts, { desc = "Signature help" }))
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, vim.tbl_extend('force', bufopts, { desc = "Add workspace folder" }))
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, vim.tbl_extend('force', bufopts, { desc = "Remove workspace folder" }))
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, vim.tbl_extend('force', bufopts, { desc = "List workspace folders" }))
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, vim.tbl_extend('force', bufopts, { desc = "Type definition" }))
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, vim.tbl_extend('force', bufopts, { desc = "Rename symbol" }))
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', bufopts, { desc = "Code action" }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', bufopts, { desc = "Go to references" }))
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, vim.tbl_extend('force', bufopts, { desc = "Format buffer" }))
end

-- ===========================
-- Setup LSP servers (new API)
-- ===========================

-- Go
vim.lsp.config("gopls", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- OCaml
vim.lsp.config("ocamllsp", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Enable the LSP servers
vim.lsp.enable({"gopls", "ocamllsp"})

-- ===========================
-- Diagnostic Configuration
-- ===========================
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
