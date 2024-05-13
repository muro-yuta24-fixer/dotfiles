local status, ls = pcall(require, "luasnip")

if not status then
  return
end

local s = ls.snippet
local t = ls.text_node

local M = {}

M.snippet = function(snippet, node) return s("tw-" .. snippet, { t(node) }) end

return M
