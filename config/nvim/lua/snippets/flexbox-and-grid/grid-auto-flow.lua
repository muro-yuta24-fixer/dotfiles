-- Grid Auto Flow
local snippet = require("snippets.utils").snippet

return {
  snippet("grid-flow-row", "grid-auto-flow: row;"),
  snippet("grid-flow-col", "grid-auto-flow: column;"),
  snippet("grid-flow-row-dense", "grid-auto-flow: row dense;"),
  snippet("grid-flow-col-dense", "grid-auto-flow: column dense;"),
}
