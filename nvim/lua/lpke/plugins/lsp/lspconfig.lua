local function config()
  local lspconfig = require('lspconfig')
  local cmp_nvim_lsp = require('cmp_nvim_lsp')
  local helpers = require('lpke.core.helpers')
  local tc = lpke_theme_colors

  -- theme
  helpers.set_hl('DiagnosticVirtualTextError', { fg = tc.lovefaded, italic = true })
  helpers.set_hl('DiagnosticVirtualTextWarn', { fg = tc.goldfaded, italic = true })
  helpers.set_hl('DiagnosticVirtualTextHint', { fg = tc.irisfaded, italic = true })
  helpers.set_hl('DiagnosticVirtualTextInfo', { fg = tc.foamfaded, italic = true })
  helpers.set_hl('DiagnosticVirtualTextOk', { fg = tc.growth, italic = true })
  helpers.set_hl('DiagnosticUnnecessary', { fg = tc.subtleplus })

  -- when a language server attaches to a buffer...
  local on_attach = function(client, bufnr)
    local opts = function(desc) return { buffer = bufnr, desc = desc  } end

    -- TODO - ensure covered:
    -- vim.lsp.buf.hover()
    -- vim.lsp.buf.format()
    -- vim.lsp.buf.references()
    -- vim.lsp.buf.implementation()
    -- vim.lsp.buf.code_action()

    -- toggle diagnostics
    -- TODO - use api instead of global variable, reuse func
    Lpke_diagnostics_active = true
    -- current buffer only
    helpers.keymap_set{'n', '<F2>d', function()
      Lpke_diagnostics_active = not Lpke_diagnostics_active
      if Lpke_diagnostics_active then
        vim.cmd('silent! lua vim.diagnostic.show(nil, 0)')
      else
        vim.diagnostic.hide(nil, 0)
      end
    end}
    -- all buffers
    helpers.keymap_set{'n', '<F2>D', function()
      Lpke_diagnostics_active = not Lpke_diagnostics_active
      if Lpke_diagnostics_active then
        vim.cmd('silent! lua vim.diagnostic.show()')
      else
        vim.diagnostic.hide()
      end
    end}

    -- set keybinds
    helpers.keymap_set_multi({
      {'n', 'gr', vim.lsp.buf.rename, opts('Smart rename')},

      -- hover info
      {'n', 'gh', vim.lsp.buf.hover, opts('Show documentation for what is under cursor')},
      {'n', '<leader><leader>', vim.diagnostic.open_float, opts('Show line diagnostics')},

      -- 'problem' (diagnostic) navigation
      {'nC', '<leader>p', 'Telescope diagnostics bufnr=0', opts('Show buffer diagnostics')},
      {'n', '[p', vim.diagnostic.goto_prev, opts('Go to previous diagnostic')},
      {'n', ']p', vim.diagnostic.goto_next, opts('Go to next diagnostic')},

      -- definitions/references
      {'nC', 'gd', 'Telescope lsp_definitions', opts('Show LSP definitions')},
      {'nC', '<leader>r', 'Telescope lsp_references', opts('Show LSP references')},

      -- {'n', 'gD', vim.lsp.buf.declaration, opts('Go to declaration')},
      -- {'nC', 'gi', 'Telescope lsp_implementations', opts('Show LSP implementations')},
      -- {'nC', 'gt', 'Telescope lsp_type_definitions', opts('Show LSP type definitions')},
      -- {'nv', '<leader>ca', vim.lsp.buf.code_action, opts('See available code actions')},
      -- {'nC', '<leader>rs', 'LspRestart', opts('Restart LSP')},
    })
  end

  -- used to enable autocompletion (assign to every lsp server config)
  local capabilities = cmp_nvim_lsp.default_capabilities()

  -- Change the Diagnostic symbols in the sign column (gutter)
  -- (not in youtube nvim video)
  local signs = { Error = '■', Warn = '▲', Hint = '◉', Info = '●' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
  end

  -- configure LSP servers
  lspconfig['html'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig['tsserver'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig['cssls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig['tailwindcss'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  lspconfig['jsonls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'json', 'jsonc' },
  })

  lspconfig['graphql'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'graphql', 'gql', 'svelte', 'typescriptreact', 'javascriptreact' },
  })

  lspconfig['emmet_ls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'svelte' },
  })

  lspconfig['lua_ls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
      Lua = {
        -- make the language server recognize 'vim' global
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
      },
    },
  })

  lspconfig['bashls'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { 'sh' },
  })
end

return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- completions
  },
  config = config,
}
