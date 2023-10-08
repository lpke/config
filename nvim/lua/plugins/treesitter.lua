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

  -- TODO
  -- vim.api.nvim_set_hl(0, 'TSField', { italic = false })
end

return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = config,
}
