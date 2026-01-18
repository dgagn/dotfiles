local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local tex = {}

function tex.setup()
  ls.add_snippets("tex", {
    s(
      "beg",
      fmta(
        [[
  \begin{<>}
  <>
  \end{<>}
  ]],
        { i(1), i(2), rep(1) }
      )
    ),

    s("it", fmta([[\item <>]], { i(1) })),

    s(
      "-i",
      fmta(
        [[
  \begin{itemize}
  \item <>
  \end{itemize}
  ]],
        { i(1) }
      )
    ),

    s(
      "enum",
      fmta(
        [[
  \begin{enumerate}
  \item <>
  \end{enumerate}
  ]],
        { i(1) }
      )
    ),

    s(
      "fig",
      fmta(
        [[
  \begin{figure}[<>]
    \centering
    \includegraphics[width=<>]{<>}
    \caption{<>}
    \label{fig:<>}
  \end{figure}
  ]],
        { i(1, "htbp"), i(2, "\\linewidth"), i(3), i(4), i(5) }
      )
    ),

    s(
      "tbl",
      fmta(
        [[
  \begin{table}[<>]
    \centering
    \caption{<>}
    \label{tab:<>}
    \begin{tabular}{<>}
    <>
    \end{tabular}
  \end{table}
  ]],
        { i(1, "htbp"), i(2), i(3), i(4), i(5) }
      )
    ),

    s(
      "eq",
      fmta(
        [[
  \begin{equation}
  <>
  \end{equation}
  ]],
        { i(1) }
      )
    ),

    s(
      "blo",
      fmta(
        [[
  \begin{block}{<>}
  <>
  \end{block}
  ]],
        { i(1), i(2) }
      )
    ),

    s(
      "center",
      fmta(
        [[
  \begin{center}
  <>
  \end{center}
  ]],
        { i(1) }
      )
    ),

    s("bf", fmta([[\textbf{<>}]], { i(1) })),
    s("itx", fmta([[\textit{<>}]], { i(1) })),
    s("tt", fmta([[\texttt{<>}]], { i(1) })),

    s("sec", fmta([[\section{<>}]], { i(1) })),
    s("ssec", fmta([[\subsection{<>}]], { i(1) })),

    s(
      "fra",
      fmta(
        [[
  \begin{frame}{<>}
  <>
  \end{frame}
  ]],
        { i(1), i(2) }
      )
    ),

    s(
      "cols",
      fmta(
        [[
  \begin{columns}[T,onlytextwidth]
  <>
  \end{columns}
  ]],
        { i(1) }
      )
    ),

    s(
      "col",
      fmta(
        [[
  \begin{column}{<>\textwidth}
  <>
  \end{column}
  ]],
        { i(1, "0.5"), i(2) }
      )
    ),
  })
end

return tex
