local snippets = require("ovior.plugin.lsp.snippets")

local in_context = snippets.in_context

local rust = {}

local function in_file_context(additional)
  local contexts = { "source_file", "declaration_list" }
  if additional then
    for _, v in ipairs(additional) do
      table.insert(contexts, v)
    end
  end
  return snippets.in_context(contexts)
end

function rust.setup()
  local ls = require("luasnip")
  local s, i, t = ls.s, ls.insert_node, ls.text_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.add_snippets("rust", {
    s("d", fmt("#[derive({})]", { i(1, "Debug") }), {
      condition = in_file_context(),
      show_condition = in_file_context(),
    }),
    s(
      "e",
      fmt(
        [[
        enum {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "t",
      fmt(
        [[
        trait {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "impl",
      fmt(
        [[
        impl {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context({ "impl_item" }),
        show_condition = in_file_context({ "impl_item" }),
      }
    ),
    s(
      "implf",
      fmt(
        [[
        impl {} for {} {{
            {}
        }}
        ]],
        { i(1, "Trait"), i(2, "Type"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "s",
      fmt(
        [[
        struct {} {{
            {}
        }}
        ]],
        { i(1, "Name"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "if",
      fmt(
        [[
        if {} {{
            {}
        }}
        ]],
        { i(1, "true"), i(0) }
      ),
      {
        condition = in_context({ "block", "_expr" }),
        show_condition = in_context({ "block", "_expr" }),
      }
    ),
    s(
      "ifl",
      fmt(
        [[
        if let {} = {} {{
            {}
        }}
        ]],
        { i(1, "value"), i(2, "expr"), i(0) }
      ),
      {
        condition = in_context({ "block", "_expr" }),
        show_condition = in_context({ "block", "_expr" }),
      }
    ),
    s(
      "ifls",
      fmt(
        [[
        if let Some({}) = {} {{
            {}
        }}
        ]],
        { i(1, "value"), i(2, "expr"), i(0) }
      ),
      {
        condition = in_context({ "block", "_expr" }),
        show_condition = in_context({ "block", "_expr" }),
      }
    ),
    s(
      "l",
      fmt(
        [[
        let {}
        ]],
        { i(0) }
      ),
      {
        condition = in_context({ "block", "_expr" }),
        show_condition = in_context({ "block", "_expr" }),
      }
    ),
    s(
      "le",
      fmt(
        [[
        let {} = {} else {{
            {}
        }};
        ]],
        { i(1, "value"), i(2, "expr"), i(0) }
      ),
      {
        condition = in_context({ "block", "_expr", "scoped_identifier" }),
        show_condition = in_context({ "block", "_expr", "scoped_identifier" }),
      }
    ),
    s(
      "w",
      fmt(
        [[
        while {} {{
            {}
        }}
        ]],
        { i(1, "true"), i(0) }
      ),
      {
        condition = in_context({ "block", "_expr" }),
        show_condition = in_context({ "block", "_expr" }),
      }
    ),
    s(
      "for",
      fmt(
        [[
        for {} in {} {{
            {}
        }}
        ]],
        { i(1, "elem"), i(2, "collection"), i(0) }
      ),
      {
        condition = in_context({ "block", "_expr" }),
        show_condition = in_context({ "block", "_expr" }),
      }
    ),
    s(
      "fori",
      fmt(
        [[
        for {} in 0..{} {{
            {}
        }}
        ]],
        { i(1, "elem"), i(2, "collection"), i(0) }
      ),
      {
        condition = in_context({ "block", "_expr" }),
        show_condition = in_context({ "block", "_expr" }),
      }
    ),
    s("todo", { t("todo!()") }, {
      condition = in_context({ "block", "_expr" }),
      show_condition = in_context({ "block", "_expr" }),
    }),
    s(
      "modtest",
      fmt(
        [[
        #[cfg(test)]
        mod tests {{
            use super::*;

            {}
        }}
        ]],
        { i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "modte",
      fmt(
        [[
        #[cfg(test)]
        mod tests {{
            use super::*;

            {}
        }}
        ]],
        { i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "test",
      fmt(
        [[
        #[test]
        fn {}() {{
            {}
        }}
        ]],
        { i(1, "test"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "atest",
      fmt(
        [[
        #[tokio::test]
        async fn {}() {{
            {}
        }}
        ]],
        { i(1, "test"), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "f",
      fmt(
        [[
        fn {}({}) {{
            {}
        }}
        ]],
        { i(1, "name"), i(2), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "fn",
      fmt(
        [[
        fn {}({}) {{
            {}
        }}
        ]],
        { i(1, "name"), i(2), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "af",
      fmt(
        [[
        async fn {}({}) {{
            {}
        }}
        ]],
        { i(1, "name"), i(2), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
    s(
      "afn",
      fmt(
        [[
        async fn {}({}) {{
            {}
        }}
        ]],
        { i(1, "name"), i(2), i(0) }
      ),
      {
        condition = in_file_context(),
        show_condition = in_file_context(),
      }
    ),
  })
end

return rust
