local function config()
  require('nvim-surround').setup({
    -- config
  })
end

return {
  'kylechui/nvim-surround',
  version = '*', -- stable
  event = 'VeryLazy',
  config = config,
}
