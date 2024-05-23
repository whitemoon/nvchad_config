require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt
local o = vim.o

o.cursorlineopt = "both"
opt.shiftwidth = 4
opt.tabstop = 4
opt.list = true
opt.listchars = "space:･,tab:»--"

opt.spelllang = "en_us,cjk"
opt.fileencodings = "ucs-bom,utf-8,gbk,big5,gb18030,latin1"

opt.guicursor = "n-v-c-sm:block,i-ci-ve-r-cr-o:hor20,a:blinkon100"

-- opt.fillchars = {
--   foldopen = "",
--   foldclose = "",
--   fold = " ",
--   foldsep = " ",
--   diff = "╱",
--   eob = " ",
-- }

-- Folding
opt.foldlevel = 99

if vim.version().minor >= 10 then
  opt.foldmethod = "expr"
  opt.foldexpr = "v:lua.require'configs.foldexpr'.foldexpr()"
  opt.foldtext = ""
  opt.fillchars = "fold: "

  opt.smoothscroll = true
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

if vim.g.neovide then
  vim.o.guifont = "GeistMono Nerd Font:h13"
  -- vim.g.neovide_refresh_rate = 75
  -- vim.g.neovide_transparency = 0.9
  -- transparent popupmenu and float window
  -- vim.o.winblend = 80
  -- vim.o.pumblend = 80

  -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.g.neovide_cursor_vfx_mode = "ripple"
  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_hide_mouse_when_typing = true
end

require "autocmds"
