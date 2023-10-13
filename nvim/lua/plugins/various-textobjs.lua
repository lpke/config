local function config()
  local keymaps = {
    -- subword (camelCase, snake_case, kebab-case)
    {'oxC', 'i<leader>w', [[lua require('various-textobjs').subword('inner')]]},
    {'oxC', 'a<leader>w', [[lua require('various-textobjs').subword('outer')]]},
  }
  require('lpke.helpers').keymap_set_multi(keymaps)

  -- options
  require('various-textobjs').setup({
    -- lines to seek forwards for "small" textobjs (mostly characterwise textobjs)
    -- set to 0 to only look in the current line
    lookForwardSmall = 5,

    -- lines to seek forwards for "big" textobjs (mostly linewise textobjs)
    lookForwardBig = 15,

    useDefaultKeymaps = false,
    disabledKeymaps = {},
  })
end

return {
  'chrisgrieser/nvim-various-textobjs',
  config = config,
}
