return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  cmd = "Telescope", -- Lazy load on Telescope command
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>ft", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme picker" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = { "node_modules", "%.git/" },
        layout_config = {
          horizontal = { preview_width = 0.55 },
        },
      },
      pickers = {
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          mappings = {
            n = {
              ["<C-d>"] = function(prompt_bufnr)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                local picker = action_state.get_current_picker(prompt_bufnr)
                local selections = picker:get_multi_selection()
                if #selections == 0 then
                  selections = { action_state.get_selected_entry() }
                end
                actions.close(prompt_bufnr)
                for _, entry in ipairs(selections) do
                  if entry ~= nil then
                    vim.api.nvim_buf_delete(entry.bufnr, { force = false })
                  end
                end
              end,
            },
          },
        },
        colorscheme = {
          enable_preview = true,
        },
      },
    })
  end,
}
