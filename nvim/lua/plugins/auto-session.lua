function config()
  require('auto-session').setup {
    log_level = 'error',
    -- auto_session_suppress_dirs = { '/', '~/', '~/Downloads' },
  }
end

return {
  'rmagatti/auto-session',
  config = config,
}
