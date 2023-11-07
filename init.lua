-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.opt.spelllang = "en_us,cjk"
vim.opt.fileencodings = "ucs-bom,utf-8,gbk,big5,gb18030,latin1"
vim.opt.list = true

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

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

require "custom.autocmd"
