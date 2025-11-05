local python = {}

function python.setup()
  local ls = require("luasnip")
  local s, i, t = ls.s, ls.insert_node, ls.text_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.add_snippets("python", {
    s(
      "ll",
      fmt(
        [[
        log.info('leak is %#x', {})
        ]],
        { i(1) }
      ),
      {}
    ),
    s(
      "x",
      fmt(
        [[
        %#x
        ]],
        {}
      ),
      {}
    ),
    s(
      "li",
      fmt(
        [[
        log.info({})
        ]],
        {
          i(1),
        }
      ),
      {}
    ),
  })
end

return python
