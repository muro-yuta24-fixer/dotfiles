-- Align Items
local snippet = require("snippets.utils").snippet

return {
  snippet("items-stretch", "align-items: stretch;"),
  snippet("items-start", "align-items: flex-start;"),
  snippet("items-center", "align-items: center;"),
  snippet("items-end", "align-items: flex-end;"),
  snippet("items-baseline", "align-items: baseline;"),
}
