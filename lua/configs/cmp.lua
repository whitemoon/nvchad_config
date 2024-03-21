local options = require "nvchad.configs.cmp"

options.sources = vim.tbl_deep_extend("keep", options.sources, { { name = "crates" }, { name = "rg" } })

options.experimental = {
  ghost_text = true,
}

return options
