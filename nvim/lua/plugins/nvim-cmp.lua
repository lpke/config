local function config()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  cmp.setup({
    completion = {
      completeopt = 'menu,menuone,preview,noselect',
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },
    mapping = cmp.mapping.preset.insert({
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<Esc>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    -- autocompletion suggestion sources (in order of priority)
    sources = cmp.config.sources({
      { name = 'luasnip' }, -- snippets
      { name = 'buffer' }, -- text within current buffer
      { name = 'path' }, -- file system paths
    })
  })
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'L3MON4D3/LuaSnip', -- snippet engine
    'saadparwaiz1/cmp_luasnip', -- snippet autocompletion
  },
  config = config,
}
