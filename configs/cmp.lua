local cmp = require "cmp"
local opts = require "plugins.configs.cmp"

opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
  { name = "crates" },
}))
opts.experimental = {
  ghost_text = {
    hl_group = "CmpGhostText",
  },
}

opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
  ["<CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  },
})

return opts
