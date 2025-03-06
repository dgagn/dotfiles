return {
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    opts = {
      scope = "line",
      placement = "top",
      update_event = {
        "BufReadPost",
        "DiagnosticChanged",
      },
    },
  }
}
