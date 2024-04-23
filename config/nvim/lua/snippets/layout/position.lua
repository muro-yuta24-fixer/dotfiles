local snippet = require("snippets.utils").snippet

return {
  snippet("static", "position: static;"),
  snippet("fixed", "position: fixed;"),
  snippet("absolute", "position: absolute;"),
  snippet("relative", "position: relative;"),
  snippet("sticky", "position: sticky;"),
}
