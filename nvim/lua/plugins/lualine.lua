local options = require('lpke.options')
local helpers = require('lpke.helpers')

-- mappings for display
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
local filetypes = {
  { 'javascript', 'js' },
  { 'typescript', 'ts' },
  { 'javascriptreact', 'jsreact' },
  { 'typescriptreact', 'tsreact' },
}

local function config()
  local tc = lpke_theme_colors
  local refresh = require('lualine').refresh

  local custom_theme = {
    normal = {
      a = {bg = tc.overlayplus, fg = tc.subtleplus},
      b = {bg = tc.overlay, fg = tc.subtleplus},
      c = {bg = tc.overlay, fg = tc.subtleplus},
    },
    insert = {
      a = {bg = tc.overlayplus, fg = tc.text},
      b = {bg = tc.overlay, fg = tc.subtleplus},
      c = {bg = tc.overlay, fg = tc.subtleplus},
    },
    visual = {
      a = {bg = tc.growth, fg = tc.base},
      b = {bg = tc.overlay, fg = tc.subtleplus},
      c = {bg = tc.overlay, fg = tc.subtleplus},
    },
    replace = {
      a = {bg = tc.love, fg = tc.base},
      b = {bg = tc.overlay, fg = tc.subtleplus},
      c = {bg = tc.overlay, fg = tc.subtleplus},
    },
    command = {
      a = {bg = tc.overlayplus, fg = tc.iris},
      b = {bg = tc.overlay, fg = tc.subtleplus},
      c = {bg = tc.overlay, fg = tc.subtleplus},
    },
    terminal = {
      a = {bg = tc.iris, fg = tc.base},
      b = {bg = tc.overlay, fg = tc.subtleplus},
      c = {bg = tc.overlay, fg = tc.subtleplus},
    },
    inactive = {
      a = {bg = tc.surface, fg = tc.mutedplus},
      b = {bg = tc.surface, fg = tc.mutedplus},
      c = {bg = tc.surface, fg = tc.mutedplus},
    },
  }

  lpke_show_cwd = true
  lpke_full_path = true
  lpke_show_encoding = false

  -- re-usable/custom components
  local filename = {
    'filename',
    path = 1,
    fmt = function(str)
      -- only show filename when: toggled off OR not a normal buffer (eg help, netrw)
      local normal_buffer = vim.bo.buftype == '' and vim.bo.filetype ~= 'netrw'
      return (lpke_full_path and normal_buffer) and str or helpers.get_path_tail(str)
    end,
    on_click = function() lpke_full_path = not lpke_full_path; refresh() end,
    shorting_target = 40,
    icons_enabled = true,
    symbols = {
      modified = '●',
      readonly = '',
      unnamed = '[No Name]',
      newfile = '[New]',
    },
  }
  local session_name = function() return helpers.formatted_session_name('◉ ') end
  local cwd_folder = helpers.get_cwd_folder

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
          on_click = function() lpke_show_cwd = not lpke_show_cwd; refresh() end
        },
      },
      lualine_b = {
        {
          cwd_folder,
          cond = function() return lpke_show_cwd end,
          on_click = function() lpke_show_cwd = not lpke_show_cwd; refresh() end,
          color = function()
            local cwd = helpers.get_cwd_folder()
            local session = helpers.get_session_name()
            if cwd == session then
              return { gui = 'bold', fg = tc.textminus }
            elseif session then
              return { gui = 'bold' }
            else
              return { gui = '' }
            end
            return ((cwd == session) and { fg = tc.foam, gui = 'bold' } or ({ gui = 'bold' }))
          end,
        },
        filename,
        {
          'branch',
          color = { gui = 'italic' },
        },
      },
      lualine_c = {'diff', 'diagnostics'},
      lualine_x = {
        {
          'encoding',
          cond = function() return lpke_show_encoding end,
          color = { fg = tc.subtle },
        },
        {
          'fileformat',
          cond = function() return lpke_show_encoding end,
          icons_enabled = true,
          color = { fg = tc.subtle },
          symbols = {
            unix = 'LF', -- LF
            dos = 'CRLF', -- CRLF
            mac = 'CR', -- CR
          },
        },
        {
          'filetype',
          fmt = function(str) return helpers.map_string(str, filetypes) end,
          on_click = function() lpke_show_encoding = not lpke_show_encoding; refresh() end,
          color = function() if lpke_show_encoding then return { gui = 'bold' } end end
        },
        {
          session_name,
          cond = function()
            local cwd = helpers.get_cwd_folder()
            local session = helpers.get_session_name()
            return session and (not (cwd == session))
          end,
          color = { gui = 'bold', fg = tc.textminus },
        },
      },
      lualine_y = {'progress', 'location'},
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { filename },
      lualine_x = {'location'},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  })

  -- options when using lualine
  vim.cmd('set noshowmode')
  vim.o.laststatus = options.vim_opts.laststatus -- override plugin control of this

  -- keymaps when using lualine
  local keymaps = {
    {'n', '<A-d>', function() lpke_show_cwd = not lpke_show_cwd; refresh() end}, -- toggle cwd
    {'n', '<A-f>', function() lpke_full_path = not lpke_full_path; refresh() end}, -- toggle file path
    {'n', '<A-e>', function() lpke_show_encoding = not lpke_show_encoding; refresh() end}, -- toggle encoding info
  }
  helpers.keymap_set_multi(keymaps)

end

return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  priority = 800,
  config = config,
}
