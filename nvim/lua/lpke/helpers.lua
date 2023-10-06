local is_wsl = vim.fn.exists('$WSL_DISTRO_NAME')

local function combine_tables(defaultTable, newTable)
  for k, v in pairs(newTable) do
    defaultTable[k] = v
  end
  return defaultTable
end

-- convert my options table into vim.opt.<key> = <value>
local function set_options(options)
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

-- parses a table containing custom keymap args and sets the keymap
local function keymap_set(keymap)
  local mode, lhs, rhs, opts = unpack(keymap)
  opts = combine_tables({ noremap = true }, opts or {})
  local modes = {}

  for char in mode:gmatch('.') do
    if char == 'R' then
      opts.noremap = false
    elseif char == 'E' then
      opts.expr = true
    elseif char == 'C' then
      rhs = '<cmd>' .. rhs .. '<cr>'
    elseif char == '!' then
      opts.silent = true
    else
      table.insert(modes, char)
    end
  end

  vim.keymap.set(modes, lhs, rhs, opts)
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

-- getter and setters for highlight colors
local function get_hl(name)
  return vim.api.nvim_get_hl(0, { name = name })
end
local function set_hl(name, hl)
  vim.api.nvim_set_hl(0, name, hl)
end

-- toggle 'list' option (show whitespace chars) and highlight
local non_text_hl = {}
local has_toggled_whitespace = false
local function toggle_whitespace_hl(hl_name)
  if not has_toggled_whitespace then
    non_text_hl = get_hl('NonText')
    has_toggled_whitespace = true
  end

  local is_list = vim.wo.list
  vim.wo.list = not is_list

  if not is_list then -- if not *previously*
    local target_hl = get_hl(hl_name)
    set_hl('NonText', { fg = target_hl.fg, bg = target_hl.bg })
  else
    set_hl('NonText', non_text_hl)
  end
end

return {
  is_wsl = is_wsl,
  set_options = set_options,
  keymap_set = keymap_set,
  keymap_set_multi = keymap_set_multi,
  paste_unix = paste_unix,
  toggle_whitespace_hl = toggle_whitespace_hl,
  get_hl = get_hl,
  set_hl = set_hl,
  toggle_relative_lines = toggle_relative_lines,
}

