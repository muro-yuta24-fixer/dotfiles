-- Grid Auto Rows
local snippet = require("snippets.utils").snippet

return {
  snippet("auto-rows-auto", "grid-auto-rows: auto;"),
  snippet("auto-rows-min", "grid-auto-rows: min;"),
  snippet("auto-rows-max", "grid-auto-rows: max;"),
  snippet("auto-rows-fr", "grid-auto-rows: minmax(0, 1fr);"),
}
