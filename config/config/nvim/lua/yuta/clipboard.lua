vim.opt.clipboard = "unnamedplus"

local win32yank_executable = "/mnt/c/Users/室雄太/AppData/Local/Microsoft/WinGet/Links/win32yank.exe"

if vim.fn.has("wsl") then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = win32yank_executable .. " -i --crlf",
      ["*"] = win32yank_executable .. " -i --crlf",
    },
    paste = {

      ["+"] = win32yank_executable .. " -o --crlf",
      ["*"] = win32yank_executable .. " -o --crlf",
    },
    cache_enable = 0,
  }
end
