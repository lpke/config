-- palette colors:  https://rosepinetheme.com/palette/ingredients/
-- recipes:         https://github.com/rose-pine/neovim/wiki/Recipes

local extra_colors = {
  slight = '#c0bcd2',
  smoke = '#3c3852',
  growth = '#64a6a5',
}

local function config()
  require('rose-pine').setup({
    variant = 'main', -- main, moon, dawn
    dark_variant = 'main',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = true,
    disable_float_background = false,
    disable_italics = false,

    groups = {
      background = 'base',
      background_nc = '_experimental_nc',
      panel = 'surface',
      panel_nc = 'base',
      border = 'highlight_med',
      comment = 'muted',
      link = 'iris',
      punctuation = 'subtle',

      error = 'love',
      hint = 'iris',
      info = 'foam',
      warn = 'gold',

      headings = {
        h1 = 'iris',
        h2 = 'foam',
        h3 = 'rose',
        h4 = 'gold',
        h5 = 'pine',
        h6 = 'foam',
      }
    },

    -- vim highlight groups (inspect under cursor with `:Inspect`)
    highlight_groups = {
      ColorColumn = { bg = 'rose' },
      StatusLine = { fg = 'subtle', bg = 'overlay' },
      StatusLineNC = { fg = 'subtle', bg = 'surface' },
      EndOfBuffer = { fg = 'base' }, -- remove the `~`
      CursorLine = { bg = 'none' },
      CursorLineNr = { fg = extra_colors.slight },
    }
  })

  -- save theme to global var, add extras
  theme_colors = require('rose-pine.palette')
  for k, v in pairs(extra_colors) do
    theme_colors[k] = v
  end

  -- set color scheme
  vim.cmd('colorscheme rose-pine')
end

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  lazy = false,
  priority = 1000,
  config = config
}
