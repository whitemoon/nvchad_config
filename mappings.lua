---@type MappingsTable
local M = {}

local utils = require "custom.utils"

M.general = {
  -- n = {
  --   [";"] = { ":", "enter command mode", opts = { nowait = true } },
  -- },
  v = {
    [">"] = { ">gv", "indent" },
    ["/"] = { 'y/<c-r>"<cr>' },
  },
}

-- more keybinds!

M.tabufline = {
  n = {
    -- cycle through buffers
    L = {
      function()
        require("nvchad.tabufline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    H = {
      function()
        require("nvchad.tabufline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },
  },
}

M.neotree = {
  plugin = true,
  n = {
    ["<leader>e"] = {
      function()
        require("neo-tree.command").execute { toggle = true }
      end,
      "Explorer NeoTree",
    },
  },
}

M.telescope = {
  plugin = true,
  n = {
    ["<leader>fp"] = {
      "<cmd>Telescope projects<cr>",
      "Find projects",
    },
    ["<leader>fT"] = {
      "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",
      "Find Todo/Fix/Fixme",
    },
  },
  v = {
    ["<leader>fg"] = {
      function()
        require("telescope.builtin").grep_string()
      end,
      "Find visual range words",
    },
  },
}

M.flash = {
  plugin = true,
  n = {
    s = {
      function()
        require("flash").jump()
      end,
      "Flash",
    },
    S = {
      function()
        require("flash").treesitter()
      end,
      "Flash Treesitter",
    },
  },
  x = {
    s = {
      function()
        require("flash").jump()
      end,
      "Flash",
    },
    S = {
      function()
        require("flash").treesitter()
      end,
      "Flash Treesitter",
    },
  },
  o = {
    s = {
      function()
        require("flash").jump()
      end,
      "Flash",
    },
    S = {
      function()
        require("flash").treesitter()
      end,
      "Flash Treesitter",
    },
  },
}

M.neogen = {
  plugin = true,
  n = {
    ["<leader>ln"] = {
      function()
        require("neogen").generate { type = "current" }
      end,
      "Current",
    },
    ["<leader>lc"] = {
      function()
        require("neogen").generate { type = "class" }
      end,
      "Class",
    },
    ["<leader>lu"] = {
      function()
        require("neogen").generate { type = "func" }
      end,
      "Function",
    },
    ["<leader>lt"] = {
      function()
        require("neogen").generate { type = "type" }
      end,
      "Type",
    },
    ["<leader>lU"] = {
      function()
        require("neogen").generate { type = "file" }
      end,
      "File",
    },
  },
}

M.multicursors = {
  plugin = true,
  n = {
    m = {
      "<cmd>MCstart<cr>",
      "Create a selection for word under the cursor",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>du"] = {
      function()
        require("dapui").toggle {}
      end,
      "Dap UI",
    },
    ["<leader>de"] = {
      function()
        require("dapui").eval()
      end,
      "Eval",
    },
    ["<leader>dB"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      "Breakpoint Condition",
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle Breakpoint",
    },
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      "Continue",
    },
    ["<leader>da"] = {
      function()
        require("dap").continue { before = utils.get_args }
      end,
      "Run with Args",
    },
    ["<leader>dC"] = {
      function()
        require("dap").run_to_cursor()
      end,
      "Run to Cursor",
    },
    ["<leader>dg"] = {
      function()
        require("dap").goto_()
      end,
      "Go to line (no execute)",
    },
    ["<leader>di"] = {
      function()
        require("dap").step_into()
      end,
      "Step Into",
    },
    ["<leader>dj"] = {
      function()
        require("dap").down()
      end,
      "Down",
    },
    ["<leader>dk"] = {
      function()
        require("dap").up()
      end,
      "Up",
    },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "Run Last",
    },
    ["<leader>dO"] = {
      function()
        require("dap").step_out()
      end,
      "Step Out",
    },
    ["<leader>do"] = {
      function()
        require("dap").step_over()
      end,
      "Step Over",
    },
    ["<leader>dp"] = {
      function()
        require("dap").pause()
      end,
      "Pause",
    },
    ["<leader>dr"] = {
      function()
        require("dap").repl.toggle()
      end,
      "Toggle REPL",
    },
    ["<leader>ds"] = {
      function()
        require("dap").session()
      end,
      "Session",
    },
    ["<leader>dt"] = {
      function()
        require("dap").terminate()
      end,
      "Terminate",
    },
    ["<leader>dw"] = {
      function()
        require("dap.ui.widgets").hover()
      end,
      "Widgets",
    },
  },
}

M.taplo = {
  plugin = true,
  n = {
    K = {
      function()
        if vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
          require("crates").show_popup()
        else
          vim.lsp.buf.hover()
        end
      end,
      "Show Crate Documentation",
    },
  },
}

M.rust_tools = {
  plugin = true,
  n = {
    K = { "<cmd>RustHoverActions<cr>", "Hover Actions (Rust)" },
    ["ga"] = { "<cmd>RustCodeAction<cr>", "Code Action (Rust)" },
  },
}

return M
