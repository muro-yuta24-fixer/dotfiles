local M = {}

M.browser = function()
  if vim.fn.has("wsl") then
    return "!wslview"
  else
    return "!firefox"
  end
end

M.shell = function()
  if vim.fn.has("win32") == 1 then
    return "pwsh"
  else
    return "fish"
  end
end

return M
