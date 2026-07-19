return {
  -- Disable NvChad bundled nvim-cmp (replaced by blink.cmp)
  { "hrsh7th/nvim-cmp", enabled = false },

  -- Core
  { "neovim/nvim-lspconfig", config = function() require("configs.lspconfig") end },
  { "williamboman/mason.nvim", config = function() require("configs.mason") end },
  { "williamboman/mason-lspconfig.nvim", config = function() require("configs.mason-lspconfig") end },
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "default",
        ["<C-Space>"] = { "show", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<A-1>"] = { function(cmp) cmp.accept({ index = 1 }) end },
        ["<A-2>"] = { function(cmp) cmp.accept({ index = 2 }) end },
        ["<A-3>"] = { function(cmp) cmp.accept({ index = 3 }) end },
        ["<A-4>"] = { function(cmp) cmp.accept({ index = 4 }) end },
        ["<A-5>"] = { function(cmp) cmp.accept({ index = 5 }) end },
      },
      appearance = {
        nerd_font_variant = "mono",
        kind_icons = {
          Text = "", Method = "󰆧", Function = "󰊕", Constructor = "",
          Field = "󰇽", Variable = "󰆦", Class = "󰠱", Interface = "",
          Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
          Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
          File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
          Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
          TypeParameter = "󰅲", Copilot = "",
        },
      },
      cmdline = {
        enabled = true,
        keymap = { preset = "cmdline" },
        completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
        min_keyword_length = 0,
      },
      completion = {
        keyword = { range = "full" },
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
        list = { selection = { preselect = true, auto_insert = true } },
        accept = {
          auto_brackets = {
            enabled = true,
            kind_resolution = { enabled = true },
            semantic_token_resolution = { enabled = true },
          },
        },
        menu = {
          border = "single",
          draw = {
            columns = { { "kind_icon" }, { "kind" }, { "label" }, { "label_description" } },
            components = {
              kind_icon = {
                width = { min = 3, max = 3 },
              },
            },
          },
        },
      },
      signature = { enabled = true, window = { border = "single" } },
      sources = {
        default = function(ctx)
          local ok, node = pcall(vim.treesitter.get_node)
          if ok and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            return { "buffer" }
          end
          return { "lsp", "path", "snippets", "buffer" }
        end,
        providers = {
          lsp = {
            module = "blink.cmp.sources.lsp",
            score_offset = 3,
            fallbacks = { "buffer" },
            max_items = 50,
            transform_items = function(_, items)
              local Keyword = require("blink.cmp.types").CompletionItemKind.Keyword
              return vim.tbl_filter(function(item) return item.kind ~= Keyword end, items)
            end,
          },
          path = { module = "blink.cmp.sources.path", score_offset = 3, fallbacks = { "buffer" } },
          snippets = { module = "blink.cmp.sources.snippets", score_offset = -1 },
          buffer = {
            module = "blink.cmp.sources.buffer",
            score_offset = -3,
            opts = {
              max_async_buffer_size = 50000,
              get_bufnrs = function()
                return vim.iter(vim.api.nvim_list_wins())
                  :map(function(w) return vim.api.nvim_win_get_buf(w) end)
                  :filter(function(b) return vim.bo[b].buftype ~= "nofile" end)
                  :totable()
              end,
            },
          },
        },
      },
      fuzzy = { sorts = { "exact", "score", "sort_text" } },
      snippets = { preset = "luasnip" },
    },
    config = function(_, opts)
      require("blink-cmp").setup(opts)
      pcall(function()
        local highlights = require("base46.integrations.blink")
        for hl, def in pairs(highlights) do
          vim.api.nvim_set_hl(0, hl, def)
        end
      end)
    end,
  },
  { "L3MON4D3/LuaSnip", config = function() require("configs.luasnip") end },
  { "rafamadriz/friendly-snippets" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function() require("configs.treesitter") end },
  { "stevearc/conform.nvim", event = "BufWritePre", config = function() require("configs.conform") end },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("configs.telescope") end },
  { "nvim-lua/plenary.nvim" },
  { "folke/which-key.nvim", config = true },
  { "lewis6991/gitsigns.nvim", config = function() require("configs.gitsigns") end },
  { "numToStr/Comment.nvim", config = function() require("configs.comment") end },
  { "folke/todo-comments.nvim", config = function() require("configs.todo_comments") end },

  -- File management
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("configs.nvimtree").setup() end },
  { "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  { "ahmedkhalf/project.nvim", config = function() require("configs.project") end },

  -- Autopairs (standalone — was bundled in NvChad's nvim-cmp)
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = { fast_wrap = {}, check_ts = true } },

  -- UI
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/bufferline.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
  { "stevearc/dressing.nvim", config = true },
  { "folke/noice.nvim", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" }, config = true },
  { "rcarriga/nvim-notify", config = function() require("notify") end },
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- Diagnostics
  { "folke/trouble.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("configs.trouble").setup() end },

  -- C/C++
  { "p00f/clangd_extensions.nvim", config = function() require("configs.clangd_extensions") end },
  { "Civitasv/cmake-tools.nvim", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("configs.cmake_tools") end },

  { "dnlhc/glance.nvim", cmd = "Glance", config = function() require("configs.glance") end },
  { "stevearc/overseer.nvim", cmd = { "OverseerRun", "OverseerOpen", "OverseerToggle" }, config = function() require("configs.overseer") end },
  { "hedyhli/outline.nvim", cmd = "Outline", config = function() require("configs.outline") end },

  -- Python tools (LSP/formatters installed via mason)

  -- Debugging
  { "mfussenegger/nvim-lint", config = function() require("configs.lint") end },
  { "mfussenegger/nvim-dap", config = function() require("configs.dap") end },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" }, config = true },
  { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap" }, config = function() require("configs.dap-virtual-text").setup() end },

  -- Terminal
  { "akinsho/toggleterm.nvim", config = function() require("configs.toggleterm") end },

  -- Git
  { "kdheepak/lazygit.nvim" },

  -- Testing
  { "nvim-neotest/neotest", dependencies = { "nvim-lua/plenary.nvim" }, config = function() require("configs.neotest") end },
  { "nvim-neotest/neotest-python", dependencies = { "nvim-neotest/neotest" } },

  -- Productivity
  { "folke/flash.nvim", config = true },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  { "folke/persistence.nvim", config = true },

  -- presence.nvim for Discord (already added earlier)
  { "andweeb/presence.nvim", event = { "BufReadPre", "BufNewFile" }, config = function() require("presence").setup({ auto_update = true, neovim_image_text = "Neovim", main_image = "neovim", workspace_text = "Working on %s", buttons = true }) end },
}
