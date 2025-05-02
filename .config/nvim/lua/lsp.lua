local lspconfig = require('lspconfig')
local telescopes = require('telescope.builtin')

-- configure default lsp behaviors
vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

vim.api.nvim_create_user_command('DiagnosticHide', function()
  vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = false,
  })
end, {desc = 'Hide diagnostics from the language server'})

vim.api.nvim_create_user_command('DiagnosticVirtText', function()
  vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = { current_line = true },
  })
end, {desc = 'Show LSP diagnostics at the end of the current line'})

vim.api.nvim_create_user_command('DiagnosticVirtLines', function()
  vim.diagnostic.config({
    virtual_lines = { current_line = true },
    virtual_text = false,
  })
end, {desc = 'Show LSP diagnostics below the current line'})

vim.lsp.inlay_hint.enable(true)
vim.api.nvim_create_user_command('InlayHintToggle', function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {desc = 'Toggle display of inlay-hints from the language server'})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- disable snippets by default
capabilities.textDocument.completion.completionItem.snippetSupport = false

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    require('lsp_signature').on_attach()

    local opts = { noremap=true, silent=true, buffer=ev.buf }
    vim.keymap.set('n', 'grr', telescopes.lsp_references, opts)
    vim.keymap.set('n', 'gO',  telescopes.lsp_document_symbols, opts)
    vim.keymap.set('n', 'g0',  telescopes.lsp_workspace_symbols, opts)
  end
})

local servers = {
  ['rust_analyzer'] = {
    settings = {
      check = {
        command = 'clippy',
      },
    },
  },
  ['pyright'] = {},
  ['clangd'] = {
    init_options = {
      clangdFileStatus = true,
    },
  },
  ['gopls'] = {},
  ['ts_ls'] = {},
  ['texlab'] = {},
  ['bashls'] = {},
  ['html'] = {},
  ['cssls'] = {},
  ['tinymist'] = {},
  ['openscad_lsp'] = {},
  -- ['julials'] = {}
}
for lsp, server_tweaks in pairs(servers) do
    -- these settings are shared among all the servers
    local server_defaults = {
        capabilities = capabilities,
    }
    local server_setup = vim.tbl_extend('force', server_defaults, server_tweaks)
    lspconfig[lsp].setup(server_setup)
end

-- enable neovim-managed servers
vim.lsp.enable('luals')
