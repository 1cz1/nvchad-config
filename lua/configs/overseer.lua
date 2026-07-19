require('overseer').setup({
  templates = { "builtin" },
  task_list = { direction = "bottom", max_height = 12 },
  confirm = { name = "Build" },
})
