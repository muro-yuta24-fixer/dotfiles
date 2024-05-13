if vim.fn.has("wsl") then
  local clip_executable = "/mnt/c/Windows/System32/clip.exe"
  local powershell_executable = "/mnt/c/Program Files/PowerShell/7/pwsh.exe"

  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = clip_executable,
      ["-"] = clip_executable,
    },
    paste = {
      ["+"] = powershell_executable .. ' -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ["*"] = powershell_executable .. ' -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.opt.clipboard = "unnamedplus"
