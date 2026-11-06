-- Custom actions-preview.nvim backend (nui):
--   * action list on top, diff preview below
--   * the preview pane is shown only when the selected action has a diff preview
--   * the popup's top edge is fixed, so the list does not move when the preview toggles
-- Registered as `actions-preview.backend.compact` (see lua/plugins/lsp.lua).

local M = {}

function M.is_supported() return pcall(require, "nui.menu") end

---@param preview table?
local function has_diff(preview)
  if not preview then
    return false
  end
  -- cmdline: highlighted diff (delta). lines + syntax "diff": plain diff.
  -- "Preview is not available ..." comes as lines with syntax "".
  return preview.cmdline ~= nil or preview.syntax == "diff"
end

function M.select(config, actions)
  local Layout = require("nui.layout")
  local Menu = require("nui.menu")
  local Popup = require("nui.popup")

  local border_style = config.border or "single"

  -- Geometry
  local width = math.min(vim.o.columns - 4, math.max(config.min_width or 60, math.floor(vim.o.columns * (config.width or 0.6))))
  local list_height = math.min(#actions, config.max_list_height or 8)
  local preview_height = math.max(6, math.floor(vim.o.lines * (config.preview_height or 0.35)))
  local list_box_h = list_height + 2 -- + border
  local preview_box_h = preview_height + 2
  -- Fix the top row so the list stays put when the preview appears / disappears
  local row = math.max(1, math.floor((vim.o.lines - list_box_h - preview_box_h) / 2))
  local position = { row = row, col = "50%" }

  local preview_popup = Popup({
    border = { style = border_style, padding = { 0, 1 }, text = { top = " Preview " } },
  })

  local lines = {}
  for idx, action in ipairs(actions) do
    local text = ("%d. %s"):format(idx, action:title())
    local client = action:client_name()
    if client ~= "" then
      text = text .. "  [" .. client .. "]"
    end
    table.insert(lines, Menu.item(text, { index = idx, action = action }))
  end

  local layout, menu
  local caches = {} ---@type table<integer, { bufnr: integer, term_id: integer? }>
  local current ---@type integer?
  local showing_preview = false
  local closed = false
  local focus_win = vim.api.nvim_get_current_win()

  local function list_only_box() return Layout.Box({ Layout.Box(menu, { size = "100%" }) }, { dir = "col" }) end

  local function with_preview_box()
    return Layout.Box({
      Layout.Box(menu, { size = list_box_h }),
      Layout.Box(preview_popup, { size = preview_box_h }),
    }, { dir = "col" })
  end

  local function set_preview_visible(visible)
    if visible == showing_preview then
      return
    end
    showing_preview = visible
    layout:update({
      position = position,
      size = { width = width, height = list_box_h + (visible and preview_box_h or 0) },
    }, visible and with_preview_box() or list_only_box())
  end

  local function cleanup()
    closed = true
    for _, cache in pairs(caches) do
      if cache.term_id and vim.fn.jobwait({ cache.term_id }, 0)[1] == -1 then
        vim.fn.jobstop(cache.term_id)
      end
      if vim.api.nvim_buf_is_valid(cache.bufnr) then
        vim.api.nvim_buf_delete(cache.bufnr, { force = true })
      end
    end
    layout:unmount()
    if vim.api.nvim_win_is_valid(focus_win) then
      vim.api.nvim_set_current_win(focus_win)
    end
  end

  ---@param index integer
  ---@param preview table
  local function show_preview(index, preview)
    set_preview_visible(true)
    local win = preview_popup.winid
    if not (win and vim.api.nvim_win_is_valid(win)) then
      return
    end

    local cache = caches[index]
    if cache then
      vim.api.nvim_win_set_buf(win, cache.bufnr)
      return
    end

    cache = { bufnr = vim.api.nvim_create_buf(false, true) }
    caches[index] = cache
    vim.api.nvim_win_set_buf(win, cache.bufnr)
    if preview.cmdline then
      -- Run in the preview window so the terminal gets its width
      vim.api.nvim_win_call(win, function() cache.term_id = vim.fn.termopen(preview.cmdline) end)
    else
      vim.api.nvim_buf_set_lines(cache.bufnr, 0, -1, false, preview.lines)
      vim.bo[cache.bufnr].syntax = preview.syntax
      vim.bo[cache.bufnr].modifiable = false
    end
  end

  menu = Menu({
    border = { style = border_style, padding = { 0, 1 }, text = { top = " Code Actions " } },
  }, {
    lines = lines,
    keymap = config.keymap,
    on_change = function(item)
      current = item.index
      item.action:preview(function(preview)
        -- Layout changes must not run inside nui's mount / on_change
        vim.schedule(function()
          if closed or current ~= item.index then
            return -- popup closed, or selection moved on while resolving
          end
          if has_diff(preview) then
            show_preview(item.index, preview)
          else
            set_preview_visible(false)
          end
        end)
      end)
    end,
    on_submit = function(item)
      cleanup()
      item.action:apply()
    end,
    on_close = cleanup,
  })

  layout = Layout({
    relative = "editor",
    position = position,
    size = { width = width, height = list_box_h },
  }, list_only_box())
  layout:mount()
end

return M
