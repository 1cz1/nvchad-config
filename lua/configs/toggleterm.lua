local M = {}
function M.setup()
  require('toggleterm').setup{}
  vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { noremap=true, silent=true })
end
return M
