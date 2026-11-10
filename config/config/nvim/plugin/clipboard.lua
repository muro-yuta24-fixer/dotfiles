vim.opt.clipboard:append({ "unnamedplus" })

if vim.fn.has("wsl") then
  local win32yank_executable = "/mnt/c/Users/室雄太/AppData/Local/Microsoft/WinGet/Links/win32yank.exe"

  if vim.fn.executable(win32yank_executable) == 0 then
    return
  end

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
