local status, ls = pcall(require, "luasnip")

if not status then
  return
end

ls.snippets = {
  all = {
    ls.parser.parse_snippet("hoge", "jetstream attack!!!"),
  },
}
