local lua = {}

function lua.setup()
  local ls = require("luasnip")
  local util = require("ovior.plugin.lsp.snippets")
  local s, i, t = ls.s, ls.insert_node, ls.text_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.add_snippets("lua", {
    s("f", fmt([[
    function {}({})
      {}
    end
    ]], { i(1), i(2), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("lf", fmt([[
    local function {}({})
      {}
    end
    ]], { i(1), i(2), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("if", fmt([[
    if {} then
      {}
    end
    ]], { i(1, "true"), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("elseif", fmt([[
    elseif {} then
      {}
    ]], { i(1, "true"), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("for", fmt([[
    for {} = {}, {} do
      {}
    end
    ]], { i(1, "i"), i(2, "1"), i(3, "10"), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("forp", fmt([[
    for i, {} in pairs({}) do
      {}
    end
    ]], { i(1, "x"), i(2, "table"), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("fori", fmt([[
    for i, {} in ipairs({}) do
      {}
    end
    ]], { i(1, "x"), i(2, "table"), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("w", fmt([[
    while {} do
      {}
    end
    ]], { i(1, "true"), i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("l", fmt([[
    local {}
    ]], { i(0) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
    s("req", fmt([[
    require({})
    ]], { i(1) }), {
      condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
      show_condition = util.in_context({ "chunk", "function_declaration", "assignment_statement" }),
    }),
  })
end

return lua
