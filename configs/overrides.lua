local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "markdown",
    "markdown_inline",
    "lua",
    "c",
    "cpp",
    "rust",
    "toml",
    "json",
    "yaml",
    "python",
    "bash",
    "ron",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  github = {
    download_url_template = "https://mirror.ghproxy.com/https://github.com/%s/releases/download/%s/%s",
  },
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
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
  },
}

M.telescope = {
  extensions_list = { "projects", "aerial" },
}

return M
