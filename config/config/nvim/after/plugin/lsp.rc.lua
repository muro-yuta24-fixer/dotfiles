vim.lsp.inlay_hint.enable(true)

-- Diagnostics display
vim.diagnostic.config({
  virtual_text = {
    current_line = true,
    source = true,
    hl_mode = "blend",
  },
  virtual_lines = false,
  float = { source = "if_many", border = "rounded" },
  severity_sort = true,
})

-- Workspace diagnostics in quickfix
vim.keymap.set("n", "<leader>tr", vim.diagnostic.setqflist, { desc = "Show workspace diagnostics" })

-- Highlight references of the symbol under cursor (replaces vim-illuminate)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or not client:supports_method("textDocument/documentHighlight", ev.buf) then
      return
    end

    local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. ev.buf, { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = ev.buf,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = group,
      buffer = ev.buf,
      callback = vim.lsp.buf.clear_references,
    })
    vim.api.nvim_create_autocmd("LspDetach", {
      group = group,
      buffer = ev.buf,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.api.nvim_del_augroup_by_id(group)
      end,
    })
  end,
})
