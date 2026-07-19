local nvchad_lsp = require("nvchad.configs.lspconfig")
nvchad_lsp.defaults()

local capabilities = require('blink-cmp').get_lsp_capabilities(nvchad_lsp.capabilities)

local s = vim.diagnostic.severity
vim.diagnostic.config({
  virtual_text = { severity = { min = s.HINT, max = s.INFO } },
  virtual_lines = { severity = { min = s.WARN } },
  signs = { text = { [s.ERROR] = "󰅙", [s.WARN] = "", [s.INFO] = "󰋼", [s.HINT] = "󰌵" } },
  underline = true,
  update_in_insert = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

vim.lsp.config.clangd = {
  cmd = { 'clangd', '--clang-tidy' },
  filetypes = { 'c', 'cpp' },
  root_markers = { '.clangd', 'compile_commands.json', '.git' },
  capabilities = capabilities,
}

vim.lsp.config.pyright = {
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
  capabilities = capabilities,
}

vim.lsp.enable('clangd')
vim.lsp.enable('pyright')
