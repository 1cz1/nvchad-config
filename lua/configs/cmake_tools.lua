require('cmake-tools').setup({
  cmake_build_dir = "build",
  cmake_build_type = "Debug",
  cmake_executor = "terminal",
  cmake_runner = {
    default_cwd = vim.fn.getcwd(),
  },
  cmake_generate_options = {
    "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
  },
  cmake_soft_links = true,
})
