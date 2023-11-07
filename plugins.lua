local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "nvimtools/none-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
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
    opts = overrides.telescope,
  },

  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    lazy = true,
    dependencies = { "MunifTanjim/nui.nvim" },
    init = function()
      require("core.utils").load_mappings "neotree"
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        width = 25,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          h = "close_node",
          l = "open",
        },
      },
    },
  },

  {
    "xiyaowong/fast-cursor-move.nvim",
    event = "VeryLazy",
  },

  { "folke/todo-comments.nvim", opts = {}, lazy = true, event = "VeryLazy" },
  {
    "jay-babu/project.nvim",
    main = "project_nvim",
    event = "VeryLazy",
    lazy = true,
    opts = { ignore_lsp = { "lua_ls" } },
  },

  {
    "kylechui/nvim-surround",
    lazy = true,
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/flash.nvim",
    lazy = true,
    event = "VeryLazy",
    vscode = true,
    init = function()
      require("core.utils").load_mappings "flash"
    end,
    opts = {},
  },

  {
    "danymat/neogen",
    lazy = true,
    event = "VeryLazy",
    cmd = "Neogen",
    init = function()
      require("core.utils").load_mappings "neogen"
    end,
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
    event = "VeryLazy",
    lazy = true,
    dependencies = { "smoka7/hydra.nvim" },
    opts = {},
  },

  {
    "mfussenegger/nvim-dap",
    lazy = true,
    event = "VeryLazy",
    opts = {},
    dependencies = {
      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require "custom.configs.nvim-dap-ui"
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        event = "VeryLazy",
        opts = {},
      },
    },
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    end,
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
    },
    opts = function()
      return require "custom.configs.cmp"
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    lazy = true,
    ft = "rust",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function() end,
  },

  {
    "p00f/clangd_extensions.nvim",
    lazy = true,
    config = function(_, opts)
      local custom_opts = require "custom.configs.clangd"
      require("clangd_extensions").setup(vim.tbl_deep_extend("force", opts or {}, custom_opts))
    end,
    opts = {
      inlay_hints = {
        inline = false,
      },
      ast = {
        --These require codicons (https://github.com/microsoft/vscode-codicons)
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },
        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },
      },
    },
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
