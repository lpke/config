-- toggle buffer LSP diagnostics (gutter/inline)
function Lpke_diagnostic_toggle()
  vim.b.diagnostics_disabled = not vim.b.diagnostics_disabled
  local cmd = vim.b.diagnostics_disabled and 'disable' or 'enable'
  vim.schedule(function()
    pcall(function() vim.diagnostic[cmd](0) end)
  end)
  pcall(function() require('lualine').refresh() end)
end

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
  helpers.set_hl('DiagnosticUnderlineHint', { bg = tc.irisbg })
  helpers.set_hl('DiagnosticUnderlineInfo', { bg = tc.foambg })
  helpers.set_hl('DiagnosticUnderlineWarn', { bg = tc.goldbg })
  helpers.set_hl('DiagnosticUnderlineError', { bg = tc.lovebg })
  helpers.set_hl('DiagnosticUnderlineOk', { bg = tc.growthbg })

  -- when a language server attaches to a buffer...
  local on_attach = function(client, bufnr)
    -- ensure initial diagnostic option is respected
    if vim.b[bufnr].diagnostics_disabled or vim.g.diagnostics_disabled then
      vim.diagnostic.disable(bufnr)
    end

    -- TODO - ensure covered:
    -- vim.lsp.buf.hover()
    -- vim.lsp.buf.format()
    -- vim.lsp.buf.references()
    -- vim.lsp.buf.implementation()
    -- vim.lsp.buf.code_action()

    -- set keybinds
    local opts = function(desc) return { buffer = bufnr, desc = desc  } end
    helpers.keymap_set_multi({
      {'nv', '<F2>d', Lpke_diagnostic_toggle, opts('Toggle diagnostics (buffer)')},
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
  local signs = {
    Error = '■',
    Warn = '▲',
    Info = '◆',
    Hint = '●',
  }
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
