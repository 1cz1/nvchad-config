require('project_nvim').setup({
  detection_methods = { "pattern", "lsp" },
  patterns = { ".git", "Makefile", "CMakeLists.txt", "pyproject.toml", "setup.py" },
})
