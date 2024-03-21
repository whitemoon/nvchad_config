local M = {}

local map = vim.keymap.set

M.capabilities = require("nvchad.configs.lspconfig").capabilities

M.on_attach = function(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end
  local function opts(desc)
    return { buffer = bufnr, desc = desc }
  end

  map("n", "gd", function()
    require("telescope.builtin").lsp_definitions { reuse_win = true }
  end, opts "Lsp Go to definition")
  map("n", "gr", function()
    require("telescope.builtin").lsp_references { reuse_win = true }
  end, opts "Lsp Show references")
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
    },
    jsonls = {},
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
