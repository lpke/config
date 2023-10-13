-- copy current buffer id and position
lpke_copied_buffer_info = {}
function lpke_copy_buffer_id()
  lpke_copied_buffer_info.id = vim.api.nvim_get_current_buf()
  lpke_copied_buffer_info.pos = vim.fn.getcurpos()
end

-- paste saved buffer into current window (retain pasteover data)
function lpke_paste_buffer_id()
  if lpke_copied_buffer_info.id then
    -- save pasteover buffer info
    local pasteover_buf_id = vim.api.nvim_get_current_buf()
    local pasteover_cursor_pos = vim.fn.getcurpos()

    -- paste saved buffer
    vim.api.nvim_set_current_buf(lpke_copied_buffer_info.id)
    if lpke_copied_buffer_info.pos then
      vim.fn.setpos('.', lpke_copied_buffer_info.pos)
    end

    -- save pasteover buffer info
    lpke_copied_buffer_info.id = pasteover_buf_id
    lpke_copied_buffer_info.pos = pasteover_cursor_pos
  end
end
