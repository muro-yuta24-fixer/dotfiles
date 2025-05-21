vim.opt.clipboard:append({ "unnamedplus" })

if vim.fn.has("wsl") then
  if vim.fn.executable("win32yank") == 0 then
    return
  end

  local win32yank_executable = "win32yank"

  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = win32yank_executable .. " -i --crlf",
      ["*"] = win32yank_executable .. " -i --crlf",
    },
    paste = {
      ["+"] = win32yank_executable .. " -o --lf",
      ["*"] = win32yank_executable .. " -o --lf",
    },
    cache_eanbled = 1,
  }
end
