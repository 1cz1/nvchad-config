require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>o", "<cmd>Outline<CR>", { desc = "toggle outline" })
map("n", "<leader>sh", function() require('clangd_extensions.switch_source_header').switch_source_header() end, { desc = "switch source/header" })
map("n", "<F8>", function()
  local ft = vim.bo.filetype
  local name = vim.fn.expand("%:r")
  local cmd
  if ft == "c" then
    cmd = "gcc -std=c2x -Wall -Wextra -Wpedantic -Werror -Wconversion -Wshadow -Wfloat-equal -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wwrite-strings -Wlogical-op -Wduplicated-cond -Wduplicated-branches " .. name .. ".c -o " .. name .. " && ./" .. name
  elseif ft == "cpp" then
    cmd = "g++ -std=c++23 -Wall -Wextra -Wpedantic -Werror -Wconversion -Wshadow -Wfloat-equal -Wpointer-arith -Wcast-qual -Wwrite-strings -Wlogical-op -Wduplicated-cond -Wduplicated-branches " .. name .. ".cpp -o " .. name .. " && ./" .. name
  else
    vim.cmd("OverseerRun")
    return
  end
  vim.cmd("botright 12split | terminal " .. cmd)
  vim.cmd("startinsert")
end, { desc = "compile & run or overseer" })
