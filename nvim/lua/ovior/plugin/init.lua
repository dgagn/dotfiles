return {
  "tpope/vim-sleuth",
  "tpope/vim-repeat",
  {
    "lambdalisue/vim-suda",
    lazy = false,
    init = function ()
      vim.cmd [[ cnoreabbrev <expr> w!! getcmdline() ==# 'w!!' ? 'SudaWrite' : 'w!!' ]]
    end
  }
}
