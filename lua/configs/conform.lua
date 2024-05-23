local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    python = function(bufnr)
      if require("conform").get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black" }
      end
    end,
    sh = { "shfmt" },
    c = { "clang-format" },
    cpp = { "clang-format" },
    toml = { "taplo" },
    markdown = { "prettier" },
    json = { "prettier" },
  },

  formatters = {
    shfmt = {
      prepend_args = { "-i", "2" },
    },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
