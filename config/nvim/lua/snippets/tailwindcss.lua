local status, ls = pcall(require, "luasnip")

if not status then
  return
end

local add_snippet = function(snip)
  ls.add_snippets("all", snip, { snippetType = "css" })
end

-- All classes from https://tailwindcomponents.com/cheatsheet/

------------------
--    Layout    --
------------------
add_snippet(require("snippets.layout.aspect-ratio"))
-- Container: 仕様がよくわからないので後で調べる
add_snippet(require("snippets.layout.break-after"))
add_snippet(require("snippets.layout.break-before"))
add_snippet(require("snippets.layout.break-inside"))
add_snippet(require("snippets.layout.box-decoration-break"))
add_snippet(require("snippets.layout.box-sizing"))
add_snippet(require("snippets.layout.display"))
add_snippet(require("snippets.layout.float"))
add_snippet(require("snippets.layout.clear"))
add_snippet(require("snippets.layout.isolation"))
add_snippet(require("snippets.layout.object-fit"))
add_snippet(require("snippets.layout.object-position"))
add_snippet(require("snippets.layout.overflow"))
add_snippet(require("snippets.layout.overscroll-behavior"))
add_snippet(require("snippets.layout.position"))
add_snippet(require("snippets.layout.visibility"))
add_snippet(require("snippets.layout.z-index"))
-- Top / Right / Bottom / Left: 複数行にまたがるのであとでどうにかする

-------------------
--    Spacing    --
-------------------
-- Padding: 複数行にまたがるのであとでどうにかする
-- Margin: 複数行にまたがるのであとでどうにかする
add_snippet(require("snippets.spacing.space-between"))

--------------------------
--    Flexbox & Grid    --
--------------------------
add_snippet(require("snippets.flexbox-and-grid.flex-basis"))
add_snippet(require("snippets.flexbox-and-grid.flex-direction"))
add_snippet(require("snippets.flexbox-and-grid.flex-wrap"))
add_snippet(require("snippets.flexbox-and-grid.flex"))
add_snippet(require("snippets.flexbox-and-grid.flex-grow"))
add_snippet(require("snippets.flexbox-and-grid.flex-shrink"))
add_snippet(require("snippets.flexbox-and-grid.order"))
add_snippet(require("snippets.flexbox-and-grid.grid-template-columns"))
add_snippet(require("snippets.flexbox-and-grid.grid-column-start-end"))
add_snippet(require("snippets.flexbox-and-grid.grid-template-rows"))
add_snippet(require("snippets.flexbox-and-grid.grid-row-start-end"))
add_snippet(require("snippets.flexbox-and-grid.grid-auto-flow"))
add_snippet(require("snippets.flexbox-and-grid.grid-auto-column"))
add_snippet(require("snippets.flexbox-and-grid.grid-auto-rows"))
add_snippet(require("snippets.flexbox-and-grid.gap"))
add_snippet(require("snippets.flexbox-and-grid.justify-content"))
add_snippet(require("snippets.flexbox-and-grid.justify-items"))
add_snippet(require("snippets.flexbox-and-grid.justify-self"))
add_snippet(require("snippets.flexbox-and-grid.align-content"))
add_snippet(require("snippets.flexbox-and-grid.align-items"))
add_snippet(require("snippets.flexbox-and-grid.align-self"))
add_snippet(require("snippets.flexbox-and-grid.place-content"))
add_snippet(require("snippets.flexbox-and-grid.place-items"))
