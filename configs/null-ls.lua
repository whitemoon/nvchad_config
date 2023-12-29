local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp
  b.formatting.clang_format,
  -- python
  b.formatting.black,

  -- bash
  b.formatting.shfmt,

  -- toml
  b.formatting.taplo,

  -- rust
  b.formatting.rustfmt,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
