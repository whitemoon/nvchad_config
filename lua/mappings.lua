require "nvchad.mappings"

-- add yours here

local function get_args(config)
  local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
  config = vim.deepcopy(config)
  ---@cast args string[]
  config.args = function()
    local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
    return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
  end
  return config
end

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- resize
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

map("v", ">", ">gv", { desc = "indent" })
map("v", "/", 'y/<c-r>"<cr>')

map("n", "<S-l>", function()
  require("nvchad.tabufline").next()
end, { desc = "Goto next buffer" })

map("n", "<S-h>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev buffer" })

-- only delete unmodified buffers
map("n", "<leader>X", function()
  vim.t.bufs = vim.tbl_filter(function(bufnr)
    if vim.api.nvim_get_current_win() == 1000 then
      if vim.b[bufnr].custom_buffer_modified or vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
        return true
      end
    end
    return false
  end, vim.t.bufs)
end, { desc = "buffer deleted(unmodified buffer)" })

-- Telescope
map("n", "<leader>fp", function()
  require("telescope").extensions.project.project {}
end, { desc = "Telescope Find project" })

map("n", "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Telescope Find Todo/Fix/Fixme" })

map("v", "<leader>fw", function()
  require("telescope.builtin").grep_string()
end, { desc = "Telescope Find visual range words" })

map("n", "<leader>fr", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "Telescope Find live grep args" })

map("v", "<leader>fr", function()
  require("telescope").extensions.live_grep_args.grep_visual_selection()
end, { desc = "Telescope Find live grep args" })

-- flash
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

--neogen
map("n", "<leader>ln", function()
  require("neogen").generate()
end, { desc = "Neogen Current" })
map("n", "<leader>lc", function()
  require("neogen").generate { type = "class" }
end, { desc = "Neogen Class" })
map("n", "<leader>lu", function()
  require("neogen").generate { type = "func" }
end, { desc = "Neogen Function" })
map("n", "<leader>lt", function()
  require("neogen").generate { type = "type" }
end, { desc = "Neogen Type" })
map("n", "<leader>lU", function()
  require("neogen").generate { type = "file" }
end, { desc = "Neogen File" })

-- multicursors
map("n", "m", "<cmd>MCstart<cr>", { desc = "Multicursors Create a selection for word under the cursor" })

-- ssr
map("n", "<leader>sr", function()
  require("ssr").open()
end, { desc = "Ssr Structural search and replace" })

-- dap
map("n", "<leader>du", function()
  require("dapui").toggle {}
end, { desc = "Dap UI" })
map({ "n", "v" }, "<leader>de", function()
  require("dapui").eval()
end, { desc = "Eval" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
end, { desc = "Dap Breakpoint Condition" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Dap Toggle Breakpoint" })
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Dap Continue" })
map("n", "<leader>da", function()
  require("dap").continue { before = get_args }
end, { desc = "Dap Run with Args" })
map("n", "<leader>dC", function()
  require("dap").run_to_cursor()
end, { desc = "Dap Run to Cursor" })
map("n", "<leader>dg", function()
  require("dap").goto_()
end, { desc = "Dap Go to line (no execute)" })
map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Dap Step Into" })
map("n", "<leader>dj", function()
  require("dap").down()
end, { desc = "Dap Down" })
map("n", "<leader>dk", function()
  require("dap").up()
end, { desc = "Dap Up" })
map("n", "<leader>dl", function()
  require("dap").run_last()
end, { desc = "Dap Run Last" })
map("n", "<leader>dO", function()
  require("dap").step_out()
end, { desc = "Dap Step Out" })
map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Dap Step Over" })
map("n", "<leader>dp", function()
  require("dap").pause()
end, { desc = "Dap Pause" })
map("n", "<leader>dr", function()
  require("dap").repl.toggle()
end, { desc = "Dap Toggle REPL" })
map("n", "<leader>dS", function()
  require("dap").session()
end, { desc = "Dap Session" })
map("n", "<leader>dt", function()
  require("dap").terminate()
end, { desc = "Dap Terminate" })
map("n", "<leader>dw", function()
  require("dap.ui.widgets").hover()
end, { desc = "Dap Widgets" })

-- nvim-spectre
map("n", "<leader>S", function()
  require("spectre").toggle()
end, {
  desc = "Spectre Toggle",
})
map("n", "<leader>sw", function()
  require("spectre").open_visual { select_word = true }
end, {
  desc = "Spectre Search current word",
})
map("n", "<leader>sp", function()
  require("spectre").open_file_search { select_word = true }
end, {
  desc = "Spectre Search on current file",
})

-- gitsigns
map("n", "<leader>gb", function()
  require("gitsigns").blame_line { full = true }
end, {
  desc = "Blame line",
})

-- diagnostic
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "lsp floating diagnostics" })
