return {
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  {
    "lambdalisue/vim-suda",
    lazy = false,
    enabled = true,
    init = function()
      vim.cmd [[ cnoreabbrev <expr> w!! getcmdline() ==# 'w!!' ? 'SudaWrite' : 'w!!' ]]
    end
  },
  {
    'rust-lang/rust.vim',
    ft = { "rust" },
    config = function()
      vim.g.rustfmt_autosave = 1
      vim.g.rustfmt_emit_files = 1
      vim.g.rustfmt_fail_silently = 0
      vim.g.rust_clip_command = 'wl-copy'
    end
  },
}
