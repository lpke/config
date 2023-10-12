local options = require('lpke.options')
local helpers = require('lpke.helpers')

-- mode name mappings for how they should be displayed
local modes = {
  { 'NORMAL', 'NOR' },
  { 'INSERT', 'INS' },
  { 'VISUAL', 'VIS' },
  { 'V-LINE', 'V-L' },
  { 'V-BLOCK', 'V-B' },
  { 'REPLACE', 'REP' },
  { 'COMMAND', 'CMD' },
  { 'TERMINAL', 'TER' },
}

local function config()
  local tc = theme_colors
  local custom_theme = {
    normal = {
      a = {bg = tc.smoke, fg = tc.subtle},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    insert = {
      a = {bg = tc.smoke, fg = tc.slight},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    visual = {
      a = {bg = tc.growth, fg = tc.base},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    replace = {
      a = {bg = tc.love, fg = tc.base},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    command = {
      a = {bg = tc.smoke, fg = tc.iris},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    terminal = {
      a = {bg = tc.iris, fg = tc.base},
      b = {bg = tc.overlay, fg = tc.subtle},
      c = {bg = tc.overlay, fg = tc.subtle}
    },
    inactive = {
      a = {bg = tc.surface, fg = tc.muted},
      b = {bg = tc.surface, fg = tc.muted},
      c = {bg = tc.surface, fg = tc.muted}
    }
  }

  -- custom variables
  local show_encoding = false
  local full_path = true
  local show_cwd = true

  -- re-usable components
  local filename = {
    'filename',
    path = 1,
    fmt = function(str)
      return full_path and str or helpers.get_path_tail(str)
    end,
    on_click = function() full_path = not full_path end,
    shorting_target = 40,
    icons_enabled = true,
    symbols = {
      modified = '●',
      readonly = '',
      unnamed = '[No Name]',
      newfile = '[New]',
    }
  }

  require('lualine').setup({
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
      always_divide_middle = false,
      globalstatus = false,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        {
          'mode',
          fmt = function(str) return helpers.map_string(str, modes) end,
          on_click = function() show_cwd = not show_cwd end
        },
      },
      lualine_b = {
        {
          helpers.get_cwd_folder,
          cond = function() return show_cwd end,
          on_click = function() show_cwd = not show_cwd end,
          color = { gui = 'bold' },
          padding = { left = 1, right = 0 }
        },
        filename,
        {
          'branch',
          color = { gui = 'italic' }
        }
      },
      lualine_c = {'diff', 'diagnostics'},
      lualine_x = {
        {
          'encoding',
          cond = function() return show_encoding end,
          color = { fg = tc.muted }
        },
        {
          'fileformat',
          cond = function() return show_encoding end,
          icons_enabled = true,
          color = { fg = tc.muted },
          symbols = {
            unix = 'LF', -- LF
            dos = 'CRLF', -- CRLF
            mac = 'CR', -- CR
          }
        },
        {
          'filetype',
          on_click = function() show_encoding = not show_encoding end,
          color = function() if show_encoding then return { gui = 'bold' } end end
        }
      },
      lualine_y = {'progress', 'location'},
      lualine_z = {}
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  })

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
