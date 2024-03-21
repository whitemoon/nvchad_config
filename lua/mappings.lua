require "nvchad.mappings"

-- add yours here

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

-- Telescope
map("n", "<leader>fp", "<cmd>Telescope projects<cr>", { desc = "Telescope Find projects" })

map("n", "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", { desc = "Telescope Find Todo/Fix/Fixme" })

map("v", "<leader>fw", function()
  require("telescope.builtin").grep_string()
end, { desc = "Telescope Find visual range words" })

-- flash
map({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash" })
map({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })

--neogen
map("n", "<leader>ln", function()
  require("neogen").generate { type = "current" }
end, { desc = "Neogen Current" })
map("n", "<leader>lc", function()
  require("neogen").generate { type = "class" }
end, { desc = "Neogen: Class" })
map("n", "<leader>lu", function()
  require("neogen").generate { type = "func" }
end, { desc = "Neogen: Function" })
map("n", "<leader>lt", function()
  require("neogen").generate { type = "type" }
end, { desc = "Neogen: Type" })
map("n", "<leader>lU", function()
  require("neogen").generate { type = "file" }
end, { desc = "Neogen: File" })

-- multicursors
map("n", "<leader>m", "<cmd>MCstart<cr>", { desc = "Multicursors Create a selection for word under the cursor" })

-- ssr
map("n", "<leader>sr", function()
  require("ssr").open()
end, { desc = "Ssr Structural search and replace" })
