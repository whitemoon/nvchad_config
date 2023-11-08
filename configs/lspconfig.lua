local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "lua_ls", "pyright", "ruff_lsp" }

local function cusom_on_attach(client, bufnr)
  local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  if client.supports_method "textDocument/inlayHint" then
    inlay_hint(bufnr, true)
  end
  on_attach(client, bufnr)
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = cusom_on_attach,
    capabilities = capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}
local diagnostics = {
  underline = true,
  update_in_insert = false,
  virtual_text = false,
}

vim.diagnostic.config(vim.deepcopy(diagnostics))
