require('mason').setup()

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    pcall(vim.cmd.MasonUpdate)
  end,
})
