local function config()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local helpers = require('lpke.helpers')
  local tc = lpke_theme_colors

  -- theme
  -- helpers.set_hl('TelescopeBorder', { fg = tc.surface, bg = tc.surface })

  local kind_icons = {
    Text = '',
    Method = '',
    Function = '',
    Constructor = '',
    Field = '',
    Variable = '',
    Class = '',
    Interface = '',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '',
    Keyword = '',
    Snippet = '',
    Color = '',
    File = '',
    Reference = '',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
  }

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
      -- confim/reject
      ['<C-c>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({
        select = true,
      }),
      ['<Esc>'] = cmp.mapping(function(fallback)
        local active_entry = cmp.get_active_entry()
        print(active_entry)
      end, { i, c }),
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

    -- custom kind icons
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        -- concatenates kind icon with kind name
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
        -- Source
        vim_item.menu = ({
          buffer = "[Buf]",
          nvim_lsp = "[LSP]",
          luasnip = "[Snip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[LaTeX]",
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
