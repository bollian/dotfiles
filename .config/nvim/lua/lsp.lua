local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables

local lspconfig = require('lspconfig')
local buf_set_keymap = vim.api.nvim_buf_set_keymap

local capabilities = require 'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- disable snippets by default
capabilities.textDocument.completion.completionItem.snippetSupport = false

local on_attach = function(client, bufnr)
  require 'lsp_signature'.on_attach()
  -- require 'cmp_nvim_lsp'.update_cababilities(vim.lsp.protocol.make_client_capabilities)

  local opts = { noremap=true, silent=true }
  -- there are several goto def/impl/decl actions. this first one is my favorite
  buf_set_keymap(bufnr, 'n', 'gd',             '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  -- the traditional mapping
  -- buf_set_keymap(bufnr, 'n', '<c-]>',          '<cmd>lua vim.lsp.buf.definition()<cr>', opts)

  buf_set_keymap(bufnr, 'n', 'K',              '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap(bufnr, 'n', 'gD',             '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  -- buf_set_keymap(bufnr, 'n', '<c-k>',          '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap(bufnr, 'n', '1gD',            '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap(bufnr, 'n', 'gr',             '<cmd>lua require\'telescope.builtin\'.lsp_references()<cr>', opts)
  buf_set_keymap(bufnr, 'n', 'g0',             '<cmd>lua require\'telescope.builtin\'.lsp_document_symbols()<cr>', opts)
  buf_set_keymap(bufnr, 'n', 'gw',             '<cmd>lua require\'telescope.builtin\'.lsp_workspace_symbols()<cr>', opts)
  -- buf_set_keymap(bufnr, 'n', 'gr',             '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  -- buf_set_keymap(bufnr, 'n', 'g0',             '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
  -- buf_set_keymap(bufnr, 'n', 'gW',             '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
  buf_set_keymap(bufnr, 'n', '<localleader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap(bufnr, 'n', '<localleader>d', '<cmd>lua vim.diagnostic.show_line_diagnostics()<cr>', opts)
  buf_set_keymap(bufnr, 'n', '<localleader>a', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

  -- configuration for diagnostics
  buf_set_keymap(bufnr, 'n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap(bufnr, 'n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)

  -- TODO: add a mapping for goto implementation
  -- buf_set_keymap(bufnr, 'n', 'gd',          '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

local servers = {
  ["rust_analyzer"] = {},
  ["pyright"] = {},
  -- currently using gutentags
  ["clangd"] = {},
  ["gopls"] = {},
  ["tsserver"] = {},
  ["texlab"] = {},
  ["bashls"] = {},
  ["html"] = {},
  ["cssls"] = {},
  -- ["julials"] = {}
}
for lsp, server_tweaks in pairs(servers) do
    -- these settings are shared among all the servers
    local server_defaults = {
        capabilities = capabilities,
        on_attach = on_attach
    }
    local server_setup = vim.tbl_extend('force', server_defaults, server_tweaks)
    lspconfig[lsp].setup(server_setup)
end
