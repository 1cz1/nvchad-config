local M = {}
function M.setup()
  require('nvim-tree').setup({})
  vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap=true, silent=true })
end
return M
