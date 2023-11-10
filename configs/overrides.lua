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
    -- download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
    download_url_template = "https://hub.nuaa.cf/%s/releases/download/%s/%s",
  },
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- bash
    "bash-language-server",
    "shfmt",
    "shellcheck",

    -- web dev stuff
    "prettier",
    "codelldb",
    "taplo",

    -- c/cpp stuff
    -- "clangd",
    -- "clang-format",
  },
}

M.telescope = {
  extensions_list = { "projects" },
}

return M
