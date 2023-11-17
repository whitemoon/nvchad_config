local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local function custom_on_attach(client, bufnr)
  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(bufnr, true)
  end

  on_attach(client, bufnr)
end

-- if you just want default config for the servers then put them in a table
-- lua_ls installed
local opts = {
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
  setup = {},
}
--
-- lspconfig.pyright.setup { blabla}
local function setup(server)
  local server_opts = vim.tbl_deep_extend("force", {
    capabilities = vim.deepcopy(capabilities),
  }, opts.servers[server] or {})
  server_opts.on_attach = custom_on_attach

  if opts.setup[server] then
    if opts.setup[server](server, server_opts) then
      return
    end
  elseif opts.setup["*"] then
    if opts.setup["*"](server, server_opts) then
      return
    end
  end
  lspconfig[server].setup(server_opts)
end

local ensure_installed = {}

local have_mason, mlsp = pcall(require, "mason-lspconfig")
local all_mslp_servers = {}
if have_mason then
  all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
end

-- auto install from mason, not need add to overrides.lua of manualed
for server, server_opts in pairs(opts.servers) do
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

vim.diagnostic.config(vim.deepcopy(diagnostics))
