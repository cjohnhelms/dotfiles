return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- For capabilities
  },
  config = function()
    -- ===========================
    -- LSP Keymaps (global)
    -- ===========================
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap=true, silent=true, desc = "Show diagnostic" })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true, desc = "Previous diagnostic" })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true, desc = "Next diagnostic" })
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { noremap=true, silent=true, desc = "Diagnostic list" })

    -- ===========================
    -- Get LSP capabilities for autocompletion
    -- ===========================
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
  end,
}
