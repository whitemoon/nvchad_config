local M = {}

M.treesitter = function()
  local default = require "nvchad.configs.treesitter"
  default.ensure_installed = vim.tbl_deep_extend("keep", default.ensure_installed, {
    "vim",
    "vimdoc",
    "markdown",
    "markdown_inline",
    "c",
    "cpp",
    "rust",
    "toml",
    "json",
    "jsonc",
    "yaml",
    "python",
    "bash",
    "ron",
    "regex",
  })

  return default
end

M.mason = function()
  local default = require "nvchad.configs.mason"
  default.github = {
    download_url_template = "https://mirror.ghproxy.com/https://github.com/%s/releases/download/%s/%s",
  }
  default.ensure_installed = vim.tbl_deep_extend("keep", default.ensure_installed, {
    "stylua",

    -- bash fmt and lint
    "shfmt",
    "shellcheck",

    -- web dev stuff
    "prettier",
    "codelldb",
    "taplo",

    -- c/cpp stuff
    -- "clang-format",
  })

  return default
end

M.telescope = function()
  local default = require "nvchad.configs.telescope"
  default.extensions_list = vim.tbl_deep_extend("keep", default.extensions_list, { "projects" })

  return default
end

return M
