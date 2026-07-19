local lint = require("lint")

lint.linters_by_ft = {
  c = { "clangtidy" },
  cpp = { "clangtidy" },
  python = { "ruff" },
}

local timer = vim.uv.new_timer()

vim.api.nvim_create_autocmd({ "TextChangedI", "CursorHoldI" }, {
  callback = function()
    timer:stop()
    timer:start(50, 0, vim.schedule_wrap(function()
      lint.try_lint()
    end))
  end,
})
