return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local opts = { buffer = bufnr, silent = true }
      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then return "]c" end
        gs.next_hunk()
      end, vim.tbl_extend("force", opts, { expr = true, desc = "Next hunk" }))
      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then return "[c" end
        gs.prev_hunk()
      end, vim.tbl_extend("force", opts, { expr = true, desc = "Previous hunk" }))
      vim.keymap.set("n", "<leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
      vim.keymap.set("n", "<leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
    end,
  },
}
