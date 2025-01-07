---@diagnostic disable: unused-local
local status, ls = pcall(require, "luasnip")

if not status then
  return
end

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local ai = require("luasnip.nodes.absolute_indexer")
local events = require("luasnip.util.events")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.add_snippets("cs", {
  s({ trig = "class", name = "Class snippet" }, {
    t("class "),
    f(function() return vim.fn.expand("%:t:r") end),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "interface", name = "Interface snippet" }, {
    t("class "),
    f(function() return vim.fn.expand("%:t:r") end),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "record", name = "Record snippet" }, {
    t("class "),
    f(function() return vim.fn.expand("%:t:r") end),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),
  s({ trig = "struct", name = "Struct snippet" }, {
    t("class "),
    f(function() return vim.fn.expand("%:t:r") end),
    t({ " {", "    " }),
    i(0),
    t({ "", "}" }),
  }),
})