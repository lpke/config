local is_wsl = vim.fn.exists('$WSL_DISTRO_NAME')

-- convert my options table into vim.opt.<key> = <value>
local function set_options(options)
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

-- convert my shorthand keymaps table into vim.keymap.set(...)
local function set_keymaps(keymaps)
  for _i, map in ipairs(keymaps) do
    local mode, lhs, rhs, opts = unpack(map)
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

    vim.keymap.set(modes, lhs, rhs, opts)
  end
end

return {
  is_wsl = is_wsl,
  set_options = set_options,
  set_keymaps = set_keymaps,
}
