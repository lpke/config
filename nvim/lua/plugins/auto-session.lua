function config()
  local keymaps = {
    { 'n', '<BS>n', require('auto-session.session-lens').search_session }, -- open sessio'N's in telescope
    { 'nC', '<BS>N', 'SessionSave' }, -- save 'N'ew session
  }
  require('lpke.helpers').keymap_set_multi(keymaps)

  -- options
  require('auto-session').setup({
    auto_session_enabled = true,
    auto_session_suppress_dirs = { '/', '~/', '~/Downloads' },
    auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
    auto_session_enable_last_session = false, -- load last session for cwd if doesnt exist
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_use_git_branch = false, -- differentiate by git branch name
    bypass_session_save_file_types = {''}, -- dont auto-save when only buffer open is one of these file types
    log_level = 'error',
    cwd_change_handling = {
      restore_upcoming_session = false, -- enabling this causes me errors when swapping with telescope
    },
    session_lens = {
      load_on_setup = true,
      previewer = false,
      theme_conf = { border = true },
      buftypes_to_ignore = {}, -- list of buffer types that should not be deleted from current session
    },
  })

  -- command abbreviations
  vim.cmd('cabbrev SS SessionSave')
  vim.cmd('cabbrev SR SessionRestore')
  vim.cmd('cabbrev SD SessionDelete')
  vim.cmd('cabbrev Ss Autosession search')
  vim.cmd('cabbrev Sd Autosession delete')

end

return {
  'rmagatti/auto-session',
  lazy = false,
  priority = 900,
  config = config,
}