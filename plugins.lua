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
        init = function()
          require("core.utils").lazy_load "none-ls.nvim"
        end,
        config = function()
          require "custom.configs.null-ls"
        end,
      },
      { "folke/neoconf.nvim", cmd = "Neoconf", dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          automatic_installation = true,
        },
      },
    },
    opts = overrides.mason,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "mason")
      require("mason").setup(opts)

      local mr = require "mason-registry"
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
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

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2",
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
    config = function(_, opts)
      require("neo-tree").setup(opts)
    end,
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
    config = true,
  },
  {
    "jay-babu/project.nvim",
    opts = { ignore_lsp = { "lua_ls" } },
    config = function(_, opts)
      require("project_nvim").setup(opts)
    end,
  },

  {
    "kylechui/nvim-surround",
    opts = {},
  },

  {
    "folke/flash.nvim",
    vscode = true,
    init = function()
      require("core.utils").load_mappings "flash"
    end,
    opts = {},
  },

  {
    "danymat/neogen",
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
    cmd = "MCstart",
    dependencies = { "smoka7/hydra.nvim" },
    init = function()
      require("core.utils").load_mappings "multicursors"
    end,
    opts = {},
  },

  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings "dap"
    end,
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
        lazy = true,
        init = function()
          require("core.utils").load_mappings "taplo"
        end,
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
    ft = { "rust" },
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("core.utils").load_mappings "rust_tools"
      require("rust-tools").setup(opts)
    end,
  },

  {
    "p00f/clangd_extensions.nvim",
    ft = { "cpp", "c" },
    config = function(_, opts)
      require("core.utils").load_mappings "clangd"
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

  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    init = function()
      require("core.utils").load_mappings "illuminate"
    end,
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { "lsp" },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  {
    "cshuaimin/ssr.nvim",
    init = function()
      require("core.utils").load_mappings "ssr"
    end,
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
