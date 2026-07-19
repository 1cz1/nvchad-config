require('clangd_extensions').setup({
  extensions = {
    inlay_hints = {
      inline = true,
      only_current_line = false,
      show_parameter_hints = true,
      show_variable_name = true,
    },
    ast = {
      role_icons = {
        type = "",
        declaration = "",
        expression = "",
        specifier = "",
        statement = "",
        template = "",
      },
    },
  },
})
