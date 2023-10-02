local is_wsl = vim.fn.exists('$WSL_DISTRO_NAME')

-- convert my options table into vim.opt.<key> = <value>
local function set_options(options)
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

-- parses a table containing custom keymap args and sets the keymap
local function keymap_set(keymap)
  local mode, from, to, opts = unpack(keymap)
  opts = opts or {}
  local modes = {}

  for char in mode:gmatch('.') do
    if char == 'N' then
      opts.noremap = true
    elseif char == '!' then
      opts.silent = true
    else
      table.insert(modes, char)
    end
  end

  vim.keymap.set(modes, from, to, opts)
end

-- same as above but accepts multiple keymap tables in a table
local function keymap_set_multi(keymaps)
  for _i, keymap in ipairs(keymaps) do
    keymap_set(keymap)
  end
end

-- pastes from register with unix line endings
local function paste_unix(register)
  local content = vim.fn.getreg(register)
  local fixed_content = vim.fn.substitute(content, '\r\n', '\n', 'g')
  vim.fn.setreg(register, fixed_content)
  vim.cmd('normal! "' .. register .. 'p')
end

return {
  is_wsl = is_wsl,
  set_options = set_options,
  keymap_set = keymap_set,
  keymap_set_multi = keymap_set_multi,
  paste_unix = paste_unix,
}

