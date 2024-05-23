local options = require "nvchad.configs.cmp"
local cmp = require "cmp"

table.insert(options.sources, { name = "crates" })
table.insert(options.sources, { name = "rg" })

options.experimental = {
  ghost_text = true,
}

options.mapping["<CR>"] = cmp.mapping.confirm {
  behavior = cmp.ConfirmBehavior.Replace,
  select = true,
}

options.sorting = require("cmp.config.default")().sorting
table.insert(options.sorting.comparators, 1, require "clangd_extensions.cmp_scores")

return options
