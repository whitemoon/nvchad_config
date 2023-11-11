local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local function custom_on_attach(client, bufnr)
  local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if client.supports_method "textDocument/inlayHint" then
    inlay_hint(bufnr, true)
  end
  on_attach(client, bufnr)
end

-- if you just want default config for the servers then put them in a table
-- lua_ls installed
local servers = {
  pyright = {
    mason = false,
  },
  ruff_lsp = {
    mason = false,
  },
  bashls = {},
}

local ensure_installed = {}

--
-- lspconfig.pyright.setup { blabla}
for server, server_opts in pairs(servers) do
  server_opts.on_attach = server_opts.on_attach or custom_on_attach
  server_opts.capabilities = vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
  -- auto install from mason, not need add to overrides.lua of manualed
  if server_opts.mason ~= false then
    ensure_installed[#ensure_installed + 1] = server
  end
  lspconfig[server].setup(server_opts)
end

local have_mason, mlsp = pcall(require, "mason-lspconfig")
if have_mason then
  mlsp.setup { ensure_installed = ensure_installed }
end

local diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = false,
}

vim.diagnostic.config(vim.deepcopy(diagnostics))
