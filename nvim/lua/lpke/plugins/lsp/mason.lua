local function config()
  local mason = require('mason') -- package manager
  local mason_lspconfig = require('mason-lspconfig') -- lsp config module
  -- manages third-party tools such as prettier
  local mason_tool_installer = require('mason-tool-installer')

  mason.setup({
    ui = {
      icons = {
        package_installed = '●',
        package_pending = '○',
        package_uninstalled = '✖',
      },
    },
  })

  mason_lspconfig.setup({
    ensure_installed = {
      'html',
      'cssls',
      'tailwindcss',
      'tsserver',
      'jsonls',
      'graphql',
      'lua_ls',
      'emmet_ls',
      'bashls',
    },
    automatic_installation = true,
  })

  mason_tool_installer.setup({
    ensure_installed = {
      'prettier',
      'eslint_d', -- js linter
      'stylua', -- lua formatter
      'isort', -- python formatter
      'black', -- python formatter
      'pylint', -- python linter
    },
  })
end

-- keymaps
require('lpke.core.helpers').keymap_set_multi({
  {'nC', '<BS>M', 'Mason', { desc = 'Open Mason GUI' }},
})

return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = config,
}
