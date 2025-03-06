local M = {}

function M.augroup(name)
  return vim.api.nvim_create_augroup("ovior_" .. name, { clear = true })
end

function M.setup()
  local yank = require('ovior.autocmd.yank')
  local saveloc = require('ovior.autocmd.saveloc')
  local whitespace = require('ovior.autocmd.whitespace')
  local dir = require('ovior.autocmd.dir')

  yank.setup()
  saveloc.setup()
  whitespace.setup()
  dir.setup()
end

return M
