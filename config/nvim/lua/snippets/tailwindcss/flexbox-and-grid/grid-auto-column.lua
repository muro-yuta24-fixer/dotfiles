-- Grid Auto Column
local snippet = require("snippets.utils").snippet

return {
  snippet("auto-cols-auto", "grid-auto-columns: auto;"),
  snippet("auto-cols-min", "grid-auto-columns: min;"),
  snippet("auto-cols-max", "grid-auto-columns: max;"),
  snippet("auto-cols-fr", "grid-auto-columns: minmax(0, 1fr);"),
}
