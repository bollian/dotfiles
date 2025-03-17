local lspconfig = require('lspconfig')
local telescopes = require('telescope.builtin')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- disable snippets by default
capabilities.textDocument.completion.completionItem.snippetSupport = false

---@diagnostic disable-next-line: unused-local
local function on_attach(client, bufnr)
  require('lsp_signature').on_attach()

  local opts = { noremap=true, silent=true, buffer=bufnr }
  -- there are several goto def/impl/decl actions. this first one is my favorite
  vim.keymap.set('n', 'gd',             vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K',              vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gD',             vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '1gD',            vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', 'gr',             telescopes.lsp_references, opts)
  vim.keymap.set('n', 'g0',             telescopes.lsp_document_symbols, opts)
  vim.keymap.set('n', 'gw',             telescopes.lsp_workspace_symbols, opts)
  vim.keymap.set('n', '<localleader>r', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<localleader>a', vim.lsp.buf.code_action, opts)

  -- configuration for diagnostics
  vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', 'g]', vim.diagnostic.goto_next, opts)
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
  ["clangd"] = {
    init_options = {
      clangdFileStatus = true,
    },
  },
  ["gopls"] = {},
  ["ts_ls"] = {},
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
          checkThirdParty = false, -- don't prompt to load runtime files
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  ["typst_lsp"] = {
    settings = {
      exportPdf = "never"
    }
  },
  ["openscad_lsp"] = {},
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
