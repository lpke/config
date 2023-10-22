local function config()
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local helpers = require('lpke.core.helpers')
  local tc = lpke_theme_colors

  local function cmp_mapping(conds, action, custom_fallback)
    local cond_v = function() return true end
    local cond_a = function() return true end
    local cond_d = function() return true end
    for char in conds:gmatch('.') do
      if char == 'v' then
        cond_v = cmp.visible
      elseif char == 'a' then
        cond_a = cmp.get_active_entry
      elseif char == 'd' then
        cond_d = cmp.visible_docs
      end
    end
    return function(fallback)
      if (cond_v() and cond_a() and cond_d()) then
        action()
      else
        if custom_fallback then
          custom_fallback()
        else
          fallback()
        end
      end
    end
  end

  -- theme
  helpers.set_hl('CmpItemKind', { fg = tc.muted, italic = true })

  -- CMP SETUP: GENERAL/INSERT
  cmp.setup({
    -- options
    completion = {
      completeopt = 'menu,menuone,noselect,preview',
    },
    window = {
      documentation = {
        max_width = 200,
        max_height = 200,
        border = 'rounded',
        winhighlight = "FloatBorder:FloatBorder",
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
      ['<Esc>'] = { i = cmp_mapping('va', cmp.abort) },
    },

    -- autocompletion suggestion sources (in order of priority)
    sources = cmp.config.sources({
      -- { name = "nvim_lsp" }, -- LSP
      { name = 'luasnip' }, -- snippets
      { name = 'path' }, -- file system paths
      { name = 'buffer', keyword_length = 5 }, -- text within current buffer
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
        -- name
        vim_item.kind = ' ' .. helpers.map_string(vim_item.kind, {
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

  -- CMP SETUP: COMMAND-LINE
  local cmdline_mapping = {
    -- completion menu
    ['<C-n>'] = { c = cmp_mapping('v', cmp.select_next_item) },
    ['<C-p>'] = { c = cmp_mapping('v', cmp.select_prev_item) },
    ['<C-Space>'] = { c = cmp_mapping('v', cmp.mapping.complete) },
    -- preview/'docs' window
    ['<C-k>'] = { c = cmp_mapping('vd', function() cmp.scroll_docs(-4) end) },
    ['<C-j>'] = { c = cmp_mapping('vd', function() cmp.scroll_docs(4) end) },
    -- confirm/abort
    ['<Tab>'] = { c = cmp_mapping('', function() cmp.confirm({ select = true }) end) },
    ['<C-c>'] = { c = cmp_mapping('v', cmp.abort) },
    ['<Esc>'] = { c = cmp_mapping('va', cmp.abort, function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, true, true), "n", {})
    end)
    },
  }
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmdline_mapping,
    sources = {
      { name = "buffer", keyword_length = 5 },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmdline_mapping,
    sources = cmp.config.sources({
      { name = "path" },
      { name = "cmdline" },
    }),
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
