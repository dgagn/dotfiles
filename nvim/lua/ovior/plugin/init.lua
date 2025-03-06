return {
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  {
    "lambdalisue/vim-suda",
    lazy = false,
    enabled = true,
    init = function ()
      vim.cmd [[ cnoreabbrev <expr> w!! getcmdline() ==# 'w!!' ? 'SudaWrite' : 'w!!' ]]
    end
  }
}
