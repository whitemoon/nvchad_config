local M = {}

M.capabilities = require("plugins.configs.lspconfig").capabilities

M.on_attach = function(client, bufnr)
  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end

  local on_attach = require("plugins.configs.lspconfig").on_attach
  on_attach(client, bufnr)
end

-- if you just want default config for the servers then put them in a table
-- lua_ls installed
M.opts = {
  servers = {
    pyright = {
      mason = false,
    },
    ruff_lsp = {
      mason = false,
    },
    bashls = {},
    clangd = {
      mason = false,
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
    },
  },
}
--
-- lspconfig.pyright.setup { blabla}
local function setup(server)
  local lspconfig = require "lspconfig"
  local server_opts = vim.tbl_deep_extend("force", {
    capabilities = vim.deepcopy(M.capabilities),
  }, M.opts.servers[server] or {})
  server_opts.on_attach = M.on_attach

  lspconfig[server].setup(server_opts)
end

M.defaults = function()
  require("plugins.configs.lspconfig").defaults()
  local ensure_installed = {}

  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  -- auto install from mason, not need add to overrides.lua of manualed
  for server, server_opts in pairs(M.opts.servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        -- if server_opts.mason == false then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup { ensure_installed = ensure_installed, handlers = { setup } }
  end

  local diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  }

  vim.diagnostic.config(diagnostics)
end

return M
