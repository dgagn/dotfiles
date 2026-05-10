local ts = {}

function ts.setup()
  local ls = require("luasnip")
  local s, i, f = ls.s, ls.insert_node, ls.function_node
  local fmt = require("luasnip.extras.fmt").fmt

  local function words_from_filename()
    local name = vim.fn.expand("%:t:r")
    local words = {}
    for part in string.gmatch(name, "[^%W_]+") do
      words[#words + 1] = part
    end
    if #words == 0 then
      words[1] = "Component"
    end
    return words
  end

  local function pascal_from_filename(suffix)
    local words = words_from_filename()
    for idx, word in ipairs(words) do
      words[idx] = word:sub(1, 1):upper() .. word:sub(2)
    end
    return table.concat(words, "") .. (suffix or "")
  end

  local function title_from_filename()
    local words = words_from_filename()
    for idx, word in ipairs(words) do
      words[idx] = word:sub(1, 1):upper() .. word:sub(2)
    end
    return table.concat(words, " ")
  end

  local console_filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  }

  for _, filetype in ipairs(console_filetypes) do
    ls.add_snippets(filetype, {
      s(
        "cl",
        fmt("console.log({});", {
          i(1),
        }),
        {}
      ),
    })
  end

  for _, filetype in ipairs({ "javascriptreact", "typescriptreact" }) do
    ls.add_snippets(filetype, {
      s(
        "cn",
        fmt('className="{}"', {
          i(1),
        }),
        {}
      ),
      s(
        "page",
        fmt(
          [[import {{ definePageModule, Link }} from "@ovior/haven/page";

type {}Props = {{}};

function {}({{}}: {}Props) {{
  return (
    <div>
    </div>
  );
}}

export default definePageModule({{
  component: {},
  title: "{}",
}});
]],
          {
            f(function()
              return pascal_from_filename("Page")
            end),
            f(function()
              return pascal_from_filename("Page")
            end),
            f(function()
              return pascal_from_filename("Page")
            end),
            f(function()
              return pascal_from_filename("Page")
            end),
            f(title_from_filename),
          }
        ),
        {}
      ),
    })
  end

  for _, filetype in ipairs({ "html", "vue" }) do
    ls.add_snippets(filetype, {
      s(
        "cn",
        fmt('class="{}"', {
          i(1),
        }),
        {}
      ),
    })
  end
end

return ts
