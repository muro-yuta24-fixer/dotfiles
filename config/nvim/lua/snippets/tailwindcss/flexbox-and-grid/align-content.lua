-- Align Content
local snippet = require("snippets.utils").snippet

return {
  snippet("content-start", "align-content: flex-start;"),
  snippet("content-center", "align-content: center;"),
  snippet("content-end", "align-content: flex-end;"),
  snippet("content-between", "align-content: space-between;"),
  snippet("content-around", "align-content: space-around;"),
  snippet("content-evenly", "align-content: space-evenly;"),
}
