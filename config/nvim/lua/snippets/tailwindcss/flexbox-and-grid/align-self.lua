-- Align Self
local snippet = require("snippets.utils").snippet

return {
  snippet("self-auto", "align-self: auto;"),
  snippet("self-start", "align-self: flex-start;"),
  snippet("self-center", "align-self: center;"),
  snippet("self-end", "align-self: flex-end;"),
  snippet("self-stretch", "align-self: stretch;"),
  snippet("self-baseline", "align-self: baseline;"),
}
