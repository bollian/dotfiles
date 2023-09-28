local lspconfig = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- disable snippets by default
capabilities.textDocument.completion.completionItem.snippetSupport = false

local function buf_map(bufnr, mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, {
    desc = desc,
    buffer = bufnr,
  })
end

---@diagnostic disable-next-line: unused-local
local function on_attach(client, bufnr)
  require('lsp_signature').on_attach()
  local telescopes = require 'telescope.builtin'

  -- there are several goto def/impl/decl actions. this first one is my favorite
  buf_map(bufnr, 'n', 'gd', vim.lsp.buf.definition, 'Go To Definition')
  buf_map(bufnr, 'n', 'gr', telescopes.lsp_references, 'Go To References')
  buf_map(bufnr, 'n', 'K', vim.lsp.buf.hover, 'Show Documentation')
  -- this is currently used for navigation
  -- buf_map(bufnr, 'n', '<c-k>', vim.lsp.buf.signature_help, 'Show Signature Help')
  buf_map(bufnr, 'n', 'gD', vim.lsp.buf.declaration, 'Go To Declaration')
  buf_map(bufnr, 'n', '1gd', vim.lsp.buf.type_definition, 'Go To Type Definition')
  buf_map(bufnr, 'n', '1gD', vim.lsp.buf.implementation, 'Go To Implementation')
  buf_map(bufnr, 'n', '<localleader>r', vim.lsp.buf.rename, 'Rename Symbol')
  buf_map(bufnr, 'n', '<localleader>a', vim.lsp.buf.code_action, 'Code Action')
  buf_map(bufnr, 'n', 'g]', vim.diagnostic.goto_next, 'Next Diagnostic')
  buf_map(bufnr, 'n', 'g[', vim.diagnostic.goto_prev, 'Previous Diagnostic')
  buf_map(bufnr, 'v', '=', vim.lsp.buf.format, 'Format Selection')

  -- this is set globally and handles treesitter/LSP fallback
  -- buf_nmap(bufnr, '<localleader>j', telescopes.lsp_document_symbols, 'Go To Buffer Symbol')
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
  ["clangd"] = {},
  ["gopls"] = {},
  ["tsserver"] = {},
  ["texlab"] = {},
  ["bashls"] = {},
  ["html"] = {},
  ["cssls"] = {},
  ["lua_ls"] = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT', -- nvim uses luajit
        },
        diagnostics = {
          globals = {'vim'}, -- recognize the vim global for nvim plugins
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true), -- nvim runtime files
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
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
