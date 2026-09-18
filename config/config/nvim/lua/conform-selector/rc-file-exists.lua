local M = {}

-- @param pattern string
-- @return boolean
M.rc_file_exists = function(pattern)
  local rc_files = vim.fs.find(pattern, {
    upward = true,
    stop = vim.fn.getenv("HOME"),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })
  local file_count = #rc_files

  return file_count > 0
end

return M
