-- Justify Content
local snippet = require("snippets.utils").snippet

return {
  snippet("justify-start", "justify-content: flex-start;"),
  snippet("justify-center", "justify-content: center;"),
  snippet("justify-end", "justify-content: flex-end;"),
  snippet("justify-between", "justify-content: space-between;"),
  snippet("justify-around", "justify-content: space-around;"),
  snippet("justify-evenly", "justify-content: space-evenly;"),
}
