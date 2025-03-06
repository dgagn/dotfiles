return {
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    enabled = true,
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
