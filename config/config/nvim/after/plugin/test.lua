-- neotest is set up on first use (was lazy-loaded by keys)
local function neotest()
  local nt = require("neotest")
  if not vim.g.neotest_configured then
    nt.setup({
      adapters = {
        require("neotest-golang")({
          go_test_args = { "-v", "-race", "-count=1" },
          testify_enabled = false,
          warn_test_name_daps = true,
          warn_test_no_excuted = true,
        }),
        require("neotest-dotnet")({
          discovery_root = "project", -- Default
        }),
      },
    })
    vim.g.neotest_configured = true
  end
  return nt
end

vim.keymap.set("n", "<F6>", function() neotest().run.run(vim.fn.expand("%")) end, { desc = "Run test for current file" })
vim.keymap.set("n", "<S-F6>", function() neotest().run.stop() end, { desc = "Stop test" })
