local options = require "nvchad.configs.cmp"
local cmp = require "cmp"

table.insert(options.sources, { name = "crates" })
table.insert(options.sources, { name = "rg" })

options.experimental = {
  ghost_text = true,
}

options.mapping = vim.tbl_deep_extend(
  "keep",
  options.mapping,
  { ["<CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  } }
)

return options
