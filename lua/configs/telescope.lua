local M = {}
function M.setup()
  local actions = require('telescope.actions')
  require('telescope').setup{defaults = { mappings = { i = { ['<esc>'] = actions.close } } }}
  vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap=true, silent=true })
  vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap=true, silent=true })
  vim.keymap.set('n', '<leader>fw', ':Telescope grep_string<CR>', { noremap=true, silent=true })
  vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap=true, silent=true })
  vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap=true, silent=true })
end
return M
