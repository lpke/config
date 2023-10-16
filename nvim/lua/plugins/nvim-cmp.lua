local function config()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local helpers = require('lpke.helpers')
  local tc = lpke_theme_colors

  -- theme
  helpers.set_hl('CmpItemKind', { fg = tc.muted })

  cmp.setup({
    -- options
    completion = {
      completeopt = 'menu,menuone,noselect,preview',
    },
    window = {
      documentation = {
        max_width = 200,
        max_height = 200,
      },
    },

    -- keymaps: only active when menu is open
    mapping = {
      -- completion menu
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      -- preview/'docs' window
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      -- confim/abort
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
      }),
      ['<C-c>'] = cmp.mapping.abort(),
      ['<Esc>'] = function(fallback)
        if cmp.visible() then
          local active_entry = cmp.get_active_entry()
          if active_entry then
            cmp.abort()
          else
            fallback()
          end
        else
          fallback()
        end
      end,
    },

    -- autocompletion suggestion sources (in order of priority)
    sources = cmp.config.sources({
      { name = 'luasnip' }, -- snippets
      { name = 'buffer' }, -- text within current buffer
      { name = 'path' }, -- file system paths
    }),

    -- handle snippets
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end
    },

    -- kind string maps
    formatting = {
      format = function(entry, vim_item)
        -- names
        vim_item.kind = helpers.map_string(vim_item.kind, {
          {'Function', 'Func'},
          {'Constructor', 'Constr'},
          {'Variable', 'Var'},
          {'Interface', 'Interf'},
          {'Property', 'Prop'},
          {'Reference', 'Ref'},
          {'EnumMember', 'EnumMbr'},
          {'Constant', 'Const'},
          {'TypeParameter', 'TypeParam'},
        })
        -- source
        vim_item.menu = ({
          buffer = '⌨',
          nvim_lsp = '◌',
          luasnip = '☇',
          nvim_lua = '◉',
          latex_symbols = '∑',
        })[entry.source.name]
        return vim_item
      end
    },
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
