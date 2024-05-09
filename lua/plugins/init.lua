local overrides = require "configs.overrides"

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("configs.lspconfig").defaults()
    end,
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    opts = function()
      return require "configs.conform"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "jay-babu/project.nvim",
        opts = { ignore_lsp = { "lua_ls" } },
        config = function(_, opts)
          require("project_nvim").setup(opts)
        end,
      },
    },
    opts = overrides.telescope,
  },

  {
    "xiyaowong/fast-cursor-move.nvim",
    event = "VeryLazy",
  },

  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/flash.nvim",
    vscode = true,
    opts = {},
  },

  {
    "danymat/neogen",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        lua = { template = { annotation_convention = "ldoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
        typescriptreact = { template = { annotation_convention = "tsdoc" } },
        python = { template = { annotation_convention = "reST" } },
      },
    },
  },

  {
    "smoka7/multicursors.nvim",
    cmd = "MCstart",
    dependencies = { "smoka7/hydra.nvim" },
    opts = {},
  },

  {
    "mrcjkb/rustaceanvim",
    lazy = false,
    config = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            require("configs.lspconfig").on_attach(client, bufnr)
          end,
        },
        default_settings = {
          ["rust-analyzer"] = {
            checkOnSave = false,
            check = {
              command = "clippy --no-deps",
            },
          },
        },
      }
    end,
  },

  {
    "p00f/clangd_extensions.nvim",
    ft = { "cpp", "c" },
    opts = function()
      return require "configs.clangd"
    end,
  },

  {
    "cshuaimin/ssr.nvim",
    opts = {
      border = "rounded",
      min_width = 50,
      min_height = 5,
      max_width = 120,
      max_height = 25,
      adjust_window = true,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<cr>",
        replace_all = "<leader><cr>",
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          src = {
            cmp = { enabled = true },
          },
        },
      },
      { "lukas-reineke/cmp-rg" },
    },
    opts = function()
      return require "configs.cmp"
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "mfussenegger/nvim-dap",
    opts = {},
    config = function()
      require("configs.dap_config").dap()
    end,
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
        config = function(_, opts)
          require("configs.dap_config").dapui(_, opts)
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },

      {
        "mfussenegger/nvim-dap-python",
      },
    },
  },

  {
    "Mythos-404/xmake.nvim",
    event = "BufReadPost xmake.lua",
    config = true,
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    opts = function()
      return require "configs.noice"
    end,
    -- stylua: ignore
    -- keys = {
    --   { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    --   { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    --   { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    --   { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    --   { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    --   { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    --   { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    -- },
  },
  {
    "LunarVim/bigfile.nvim",
    event = "BufReadPre",
    opts = {},
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {},
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
