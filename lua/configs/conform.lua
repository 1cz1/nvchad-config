require('conform').setup({
  format_on_save = {
    timeout_ms = 500,
  },
  formatters_by_ft = {
    lua = { "stylua" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    python = { "ruff" },
  },
})
