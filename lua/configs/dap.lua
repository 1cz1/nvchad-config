local dap = require('dap')
local mason_path = vim.fn.stdpath("data") .. "/mason"

dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = mason_path .. "/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.python = {
  {
    name = "Launch file",
    type = "python",
    request = "launch",
    program = '${file}',
    pythonPath = function()
      return vim.fn.input("Python path: ", "python3")
    end,
  },
}

vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP step out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "DAP conditional breakpoint" })
