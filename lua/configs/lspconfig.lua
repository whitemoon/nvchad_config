local M = {}

local map = vim.keymap.set

M.capabilities = require("nvchad.configs.lspconfig").capabilities

M.on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions { reuse_win = true }
  end, opts "Go to definition")
  map("n", "gr", function()
    require("telescope.builtin").lsp_references { reuse_win = true }
  end, opts "Show references")
end

M.on_init = function(client, _)
  require("nvchad.configs.lspconfig").on_init(client, _)
end

-- if you just want default config for the servers then put them in a table
-- lua_ls installed
M.opts = {
  servers = {
    pyright = {},
    ruff_lsp = {},
    bashls = {},
    clangd = {
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja",
          ".vscode",
          ".git"
        )(fname) or require("lspconfig.util").find_git_ancestor(fname)
      end,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
        "--compile-commands-dir=.vscode",
      },
    },
    jsonls = {},
    taplo = {},
  },
}
--
-- lspconfig.pyright.setup { blabla}
local function setup(server)
  local lspconfig = require "lspconfig"
  local server_opts = vim.tbl_deep_extend("keep", {
    capabilities = M.capabilities,
  }, M.opts.servers[server] or {})
  server_opts.on_attach = M.on_attach
  server_opts.on_init = M.on_init

  lspconfig[server].setup(server_opts)
end

M.defaults = function()
  require("nvchad.configs.lspconfig").defaults()

  for server, _ in pairs(M.opts.servers) do
    setup(server)
  end

  local diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  }

  vim.diagnostic.config(diagnostics)
end

return M
