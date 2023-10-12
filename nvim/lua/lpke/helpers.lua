local E = {}

E.is_wsl = vim.fn.exists('$WSL_DISTRO_NAME')

function E.combine_tables(defaultTable, newTable)
  for k, v in pairs(newTable) do
    defaultTable[k] = v
  end
  return defaultTable
end

-- convert my options table into vim.opt.<key> = <value>
function E.set_options(options)
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

-- parses a table containing custom keymap args and sets the keymap
function E.keymap_set(keymap)
  local mode, lhs, rhs, opts = unpack(keymap)
  opts = E.combine_tables({ noremap = true }, opts or {})
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
function E.keymap_set_multi(keymaps)
  for _i, keymap in ipairs(keymaps) do
    E.keymap_set(keymap)
  end
end

-- pastes from register with unix line endings
function E.paste_unix(register)
  local content = vim.fn.getreg(register)
  local fixed_content = vim.fn.substitute(content, '\r\n', '\n', 'g')
  vim.fn.setreg(register, fixed_content)
  vim.cmd('normal! "' .. register .. 'p')
end

-- getter and setters for highlight colors
function E.get_hl(name)
  return vim.api.nvim_get_hl(0, { name = name })
end
function E.set_hl(name, hl)
  vim.api.nvim_set_hl(0, name, hl)
end

-- toggle 'list' option (show whitespace chars) and highlight
local non_text_hl = {}
local has_toggled_whitespace = false
function E.toggle_whitespace_hl(hl_name)
  if not has_toggled_whitespace then
    non_text_hl = E.get_hl('NonText')
    has_toggled_whitespace = true
  end

  local is_list = vim.wo.list
  vim.wo.list = not is_list

  if not is_list then -- if not *previously*
    local target_hl = E.get_hl(hl_name)
    E.set_hl('NonText', { fg = target_hl.fg, bg = target_hl.bg })
  else
    E.set_hl('NonText', non_text_hl)
  end
end

-- toggle global status line ('laststatus' option 2/3)
function E.toggle_global_status()
  if vim.o.laststatus == 3 then
    vim.o.laststatus = 2
  else
    vim.o.laststatus = 3
  end
end

-- prints a message 'over' the previous message
function E.print_over(msg, history, height)
  history = history or false
  local orig_height = vim.o.cmdheight
  vim.o.cmdheight = height or 2
  if history then
    print(msg)
  else
    vim.cmd('echo "' .. msg .. '"')
  end
  vim.o.cmdheight = orig_height
end

-- clear the latest message if it contains `target`
function E.clear_last_message(target)
  local messages = vim.fn.execute('messages')
  local lines = vim.split(messages, '\n')
  local last_line = lines[#lines]

  if string.find(last_line, target, 1, true) then
    E.print_over(' ')
  end
end

-- yank still: upwards (up to `max`)
function E.keymap_set_yank_still_upwards(max)
  for i = 1, max do
    E.keymap_set({'nC', ('y' .. i .. 'k'), ('-' .. i .. ',.y')})
  end
end

-- yank still: marks (a-z)
function E.keymap_set_yank_still_marks()
  for i = string.byte('a'), string.byte('z') do
    local letter = string.char(i)
    E.keymap_set({'nC!', ("y'" .. letter), ("'" .. letter .. ',.y')})
  end
end

-- if `str` matches an item in `mappings`, return second value for it
-- eg: 'hello', {{'hello', 'hi'}, ...} -> 'hi'
function E.map_string(str, mappings, fallback)
  for _, map in ipairs(mappings) do
    if str == map[1] then
      return map[2]
    end
  end
  return fallback or str
end

-- get last segment of a path
function E.get_path_tail(str)
  return str:match('([^/]+)$')
end

-- get cwd folder name
function E.get_cwd_folder()
  local cwd = vim.fn.getcwd()
  return E.get_path_tail(cwd)
end

-- calls a function safely (non-breaking if error)
function E.safe_call(func, silent, fallback)
  local ok, result = pcall(func)
  if ok then
    return result
  else
    if not silent then
      print('safe_call error: ' .. result)
    end
    return fallback
  end
end

return E;

