require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

local opt = vim.opt

opt.shiftwidth = 4
opt.tabstop = 4
opt.list = true
opt.listchars = "space:･,tab:»--"

opt.spelllang = "en_us,cjk"
opt.fileencodings = "ucs-bom,utf-8,gbk,big5,gb18030,latin1"

opt.guicursor = "n-v-c-sm:block,i-ci-ve-r-cr-o:hor20,a:blinkon100"

-- Folding
opt.foldlevel = 99

if vim.fn.has "nvim-0.10" == 1 then
  opt.foldmethod = "expr"
  opt.foldexpr = "v:lua.require'configs.foldexpr'.foldexpr()"

  opt.smoothscroll = true
end

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
