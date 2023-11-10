-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
local opt = vim.opt

opt.spelllang = "en_us,cjk"
opt.fileencodings = "ucs-bom,utf-8,gbk,big5,gb18030,latin1"
opt.list = true

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
-- Folding
opt.foldlevel = 99
opt.foldtext = "v:lua.require'custom.utils'.foldtext()"
-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has "nvim-0.10" == 1 then
  opt.foldmethod = "expr"
  opt.foldexpr = "v:lua.require'custom.utils'.foldexpr()"
else
  opt.foldmethod = "indent"
end

opt.guicursor = "n-v-c-sm:block,i-ci-ve-r-cr-o:hor20,a:blinkon100"
opt.cursorcolumn = true

if vim.g.neovide then
  vim.o.guifont = "Iosevka Nerd Font Mono:h15"
  vim.g.neovide_refresh_rate = 75
  -- vim.g.neovide_transparency = 0.9
  -- transparent popupmenu and float window
  -- vim.o.winblend = 80
  -- vim.o.pumblend = 80

  -- vim.g.neovide_cursor_vfx_mode = "sonicboom"
  vim.g.neovide_cursor_vfx_mode = "ripple"
  vim.g.neovide_underline_automatic_scaling = true
  vim.g.neovide_hide_mouse_when_typing = true
  -- vim.g.neovide_floating_blur_amount_x = 2.0
  -- vim.g.neovide_floating_blur_amount_y = 2.0
  -- vim.g.neovide_scroll_animation_length = 0.3
end

require "custom.autocmds"
