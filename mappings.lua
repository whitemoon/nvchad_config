---@type MappingsTable
local M = {}

local utils = require "custom.utils"

M.general = {
  n = {
    q = { "<cmd>cclose<cr>", "close quickfix" },
  },
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

M.lspconfig = {
  n = {
    ["ga"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "LSP code action",
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
      "Neogen: Current",
    },
    ["<leader>lc"] = {
      function()
        require("neogen").generate { type = "class" }
      end,
      "Neogen: Class",
    },
    ["<leader>lu"] = {
      function()
        require("neogen").generate { type = "func" }
      end,
      "Neogen: Function",
    },
    ["<leader>lt"] = {
      function()
        require("neogen").generate { type = "type" }
      end,
      "Neogen: Type",
    },
    ["<leader>lU"] = {
      function()
        require("neogen").generate { type = "file" }
      end,
      "Neogen: File",
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
      "Dap: Eval",
    },
    ["<leader>dB"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      "Dap: Breakpoint Condition",
    },
    ["<leader>db"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Dap: Toggle Breakpoint",
    },
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
      "Dap: Continue",
    },
    ["<leader>da"] = {
      function()
        require("dap").continue { before = utils.get_args }
      end,
      "Dap: Run with Args",
    },
    ["<leader>dC"] = {
      function()
        require("dap").run_to_cursor()
      end,
      "Dap: Run to Cursor",
    },
    ["<leader>dg"] = {
      function()
        require("dap").goto_()
      end,
      "Dap: Go to line (no execute)",
    },
    ["<leader>di"] = {
      function()
        require("dap").step_into()
      end,
      "Dap: Step Into",
    },
    ["<leader>dj"] = {
      function()
        require("dap").down()
      end,
      "Dap: Down",
    },
    ["<leader>dk"] = {
      function()
        require("dap").up()
      end,
      "Dap: Up",
    },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "Dap: Run Last",
    },
    ["<leader>dO"] = {
      function()
        require("dap").step_out()
      end,
      "Dap: Step Out",
    },
    ["<leader>do"] = {
      function()
        require("dap").step_over()
      end,
      "Dap: Step Over",
    },
    ["<leader>dp"] = {
      function()
        require("dap").pause()
      end,
      "Dap: Pause",
    },
    ["<leader>dr"] = {
      function()
        require("dap").repl.toggle()
      end,
      "Dap: Toggle REPL",
    },
    ["<leader>ds"] = {
      function()
        require("dap").session()
      end,
      "Dap: Session",
    },
    ["<leader>dt"] = {
      function()
        require("dap").terminate()
      end,
      "Dap: Terminate",
    },
    ["<leader>dw"] = {
      function()
        require("dap.ui.widgets").hover()
      end,
      "Dap: Widgets",
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

M.clangd = {
  plugin = true,
  n = {
    ["<leader>cR"] = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Source/Header (C/C++)" },
  },
}

return M
