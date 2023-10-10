local options = require('lpke.options')

local function config()
  local tc = theme_colors
  local custom_theme = {
    normal = {
      a = {bg = tc.overlay, fg = tc.subtle},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    insert = {
      a = {bg = tc.overlay, fg = tc.subtle},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    visual = {
      a = {bg = tc.overlay, fg = tc.subtle},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    replace = {
      a = {bg = tc.overlay, fg = tc.subtle},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    command = {
      a = {bg = tc.overlay, fg = tc.subtle},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    inactive = {
      a = {bg = tc.surface, fg = tc.muted},
      b = {bg = tc.surface, fg = tc.muted},
      c = {bg = tc.surface, fg = tc.muted}
    }
  }

  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = custom_theme,
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
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

  -- options to set only when this plugin is in use
  vim.cmd('set noshowmode')

  -- override plugin control of this option
  vim.o.laststatus = options.vim_opts.laststatus
end

return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  config = config,
}
