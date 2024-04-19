local options = require "nvchad.configs.cmp"

table.insert(options.sources, { name = "crates" })
table.insert(options.sources, { name = "rg" })

options.experimental = {
  ghost_text = true,
}

return options
