local helpers = require('lpke.helpers')

function config()
  -- update/install parsers
  pcall(require('nvim-treesitter.install').update({ with_sync = true }))
  require('nvim-treesitter.install').compilers = { 'clang' }
  helpers.clear_last_message('All parsers are up-to-date!') -- clear annoying message on startup

  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    sync_install = false, -- install parsers synchronously
    auto_install = true, -- automatically install missing parsers when entering buffer
    highlight = {
      enable = true,
      disable = {},

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    autopairs = {
      enable = true,
    },
    indent = {
      enable = true,
      disable = {},
    },
  })

  -- highlight customisations
  helpers.set_hl('@none', { fg = theme_colors.slight })
  helpers.set_hl('@variable', { italic = false, fg = theme_colors.text })
  helpers.set_hl('@property', { italic = false, fg = theme_colors.foam })
  helpers.set_hl('@parameter', { italic = false, fg = theme_colors.iris })
  helpers.set_hl('@tag.attribute', { italic = true, fg = theme_colors.iris })
  helpers.set_hl('@keyword', { italic = true, fg = theme_colors.pine })
  helpers.set_hl('@include', { italic = true, fg = theme_colors.pine })
  helpers.set_hl('@number', { fg = theme_colors.iris })
  helpers.set_hl('@constructor', { fg = theme_colors.growth })
  helpers.set_hl('@type', { fg = theme_colors.growth })
end

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = config,
}
