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
    config = function()
      require "configs.conform"
    end,
  },

  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },

  -- {
  -- 	"williamboman/mason.nvim",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"lua-language-server", "stylua",
  -- 			"html-lsp", "css-lsp" , "prettier"
  -- 		},
  -- 	},
  -- },
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
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
    -- config = true,
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
    ft = { "rust" },
  },

  {
    "p00f/clangd_extensions.nvim",
    ft = { "cpp", "c" },
    -- config = function(_, opts)
    -- 	require("clangd_extensions").setup(opts)
    -- end,
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
      { "Saecki/crates.nvim", event = { "BufRead Cargo.toml" }, opts = {} },
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
}
