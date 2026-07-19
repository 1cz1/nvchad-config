local M = {}
function M.setup()
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'c', 'cpp', 'python', 'bash' },
    highlight = { enable = true },
  })
end
return M
