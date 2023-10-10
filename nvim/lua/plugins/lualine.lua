-- local c = theme_colors
-- local custom_theme = {
--   normal = {
--     a = {bg = c.overlay, fg = c.base, gui = 'bold'},
--     b = {bg = c.overlay, fg = c.white},
--     c = {bg = c.overlay, fg = c.overlay}
--   },
--   insert = {
--     a = {bg = c.blue, fg = c.base, gui = 'bold'},
--     b = {bg = c.overlay, fg = c.white},
--     c = {bg = c.overlay, fg = c.white}
--   },
--   visual = {
--     a = {bg = c.yellow, fg = c.base, gui = 'bold'},
--     b = {bg = c.overlay, fg = c.white},
--     c = {bg = c.inactiveoverlay, fg = c.base}
--   },
--   replace = {
--     a = {bg = c.red, fg = c.base, gui = 'bold'},
--     b = {bg = c.overlay, fg = c.white},
--     c = {bg = c.base, fg = c.white}
--   },
--   command = {
--     a = {bg = c.green, fg = c.base, gui = 'bold'},
--     b = {bg = c.overlay, fg = c.white},
--     c = {bg = c.inactiveoverlay, fg = c.base}
--   },
--   inactive = {
--     a = {bg = c.overlay, fg = c.overlay, gui = 'bold'},
--     b = {bg = c.overlay, fg = c.overlay},
--     c = {bg = c.overlay, fg = c.overlay}
--   }
-- }

local function config()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
end

return {
  'nvim-lualine/lualine.nvim',
  config = config,
}
