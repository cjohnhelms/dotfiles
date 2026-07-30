return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy",
  config = function()
    -- same neutral grayscale as ~/.tmux.conf, fixed regardless of active theme
    local accent = { bg = '#3a3a3a', fg = '#ffffff' }

    require('lualine').setup({
      options = {
        theme = 'auto',
        component_separators = '',
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode', color = accent, separator = { left = '' }, right_padding = 2 } },
        lualine_b = {
          { 'filename', color = { fg = '#c0c0c0' } },
          { 'branch', color = { fg = '#808080' } },
          {
            'diff',
            diff_color = {
              added = { fg = '#c0c0c0' },
              modified = { fg = '#808080' },
              removed = { fg = '#808080' },
            },
          },
        },
        lualine_c = {
          '%=',
        },
        lualine_x = {},
        lualine_y = {
          { 'filetype', color = accent },
          { 'progress', color = accent },
        },
        lualine_z = {
          { 'location', color = accent, separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
