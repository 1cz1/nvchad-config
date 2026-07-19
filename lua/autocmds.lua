require "nvchad.autocmds"

local lsp_group = vim.api.nvim_create_augroup("CustomLSP", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(args)
    local bufopts = { noremap = true, silent = true, buffer = args.buf }
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    vim.keymap.set("n", "gr", function()
      if vim.fn.expand("<cword>") ~= "" then vim.lsp.buf.references() end
    end, vim.tbl_extend("force", bufopts, { desc = "references" }))
    vim.keymap.set("n", "K", function()
      if vim.fn.expand("<cword>") ~= "" then vim.lsp.buf.hover() end
    end, bufopts)
    vim.keymap.set({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", bufopts, { desc = "next diagnostic" }))
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", bufopts, { desc = "prev diagnostic" }))
    vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", bufopts, { desc = "line diagnostics" }))
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "code action" }))
    vim.keymap.set("n", "<leader>rn", function()
      if vim.fn.expand("<cword>") ~= "" then vim.lsp.buf.rename() end
    end, vim.tbl_extend("force", bufopts, { desc = "rename" }))

    if client and (client.name == "clangd" or client.name == "pyright") then
      vim.keymap.set("n", "<leader>ih", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
      end, vim.tbl_extend("force", bufopts, { desc = "toggle inlay hints" }))
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

local diag_hover_group = vim.api.nvim_create_augroup("DiagHover", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
  group = diag_hover_group,
  callback = function()
    local diags = vim.diagnostic.get(vim.api.nvim_get_current_buf(), {
      lnum = vim.api.nvim_win_get_cursor(0)[1] - 1,
    })
    if #diags > 0 then
      vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
    end
  end,
})

local nav_group = vim.api.nvim_create_augroup("MouseNavFix", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = nav_group,
  pattern = { "qf", "loclist" },
  callback = function()
    vim.keymap.set("n", "<LeftMouse>", function()
      vim.cmd("normal! <LeftMouse>")
      vim.cmd("normal! <CR>")
    end, { buffer = true, silent = true, desc = "open quickfix item on click" })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = nav_group,
  pattern = { "trouble" },
  callback = function()
    vim.keymap.set("n", "<LeftMouse>", function()
      vim.cmd("normal! <LeftMouse>")
      vim.cmd("normal! o")
    end, { buffer = true, silent = true, desc = "open trouble item on click" })
  end,
})

local auto_group = vim.api.nvim_create_augroup("AutoFeatures", { clear = true })

vim.api.nvim_create_autocmd("User", {
  group = auto_group,
  pattern = "DiagnosticChanged",
  callback = function()
    local count = #vim.diagnostic.get(vim.api.nvim_get_current_buf())
    if count == 0 then
      local wins = vim.api.nvim_list_wins()
      for _, w in ipairs(wins) do
        local buf = vim.api.nvim_win_get_buf(w)
        if vim.bo[buf].filetype == "trouble" then
          vim.cmd("Trouble close")
          break
        end
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = auto_group,
  pattern = { "markdown", "text", "gitcommit", "tex" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en"
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = auto_group,
  callback = function()
    vim.cmd("wincmd =")
  end,
})
