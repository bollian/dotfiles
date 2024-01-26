local function merge_into(target, extras)
  for key, value in pairs(extras) do
    target[key] = value
  end
end

merge_into(vim.opt, {
  guifont = 'UbuntuMono Nerd Font Mono:h15', -- set the font when using a graphical interface
  mouse = '', -- support mouse selection is more trouble than it's worth right now
  lazyredraw = true, -- only redraw when necessary (makes macros run faster)

  -- show whitespace
  list = true,
  listchars = {
    tab = '→ ',
    space = '·',
    nbsp = '␣',
    trail = '•',
    eol = '¶',
    precedes = '«',
    extends = '»',
  },

  -- show line numbers relative to the current position
  number = true,
  relativenumber = true,

  -- ignore casing when searching w/ all lower-case letters
  ignorecase = true,
  smartcase = true,

  foldcolumn = '1', -- Show when I'm in an open fold
  foldclose = 'all', -- Automatically close folds when leaving them
  scrolloff = 10, -- Keep the cursor 10 lines from the top/bottom of the screen
  textwidth = 80, -- Automatically hit enter for me
  hidden = true, -- Required for operations modifying multiple buffers like rename.
  cursorline = true, -- Highlight the line your cursor is on
  signcolumn = 'yes', -- Prevent the window from resizing due to the gitgutter being added
  showmode = false, -- hide the mode in the command line row (already shown by lualine)
  undofile = true, -- persist undo history between sessions

  completeopt = { 'noinsert', 'menuone', 'noselect' },
  shortmess = vim.opt.shortmess + 'c', -- avoid extra messages during completion
  pumheight = 20, -- display 20 items at most

  -- tab configuration
  tabstop = 4, -- # of spaces a tab is displayed as
  softtabstop = -1, -- insert spaces instead of tabs
  shiftwidth = 4, -- # of spaces when pressing tab and indenting
  expandtab = true, -- insert spaces instead of tabs
  smarttab = true, -- delete or insert spaces according to shiftwidth
})

-- a few custom filetype associations
local function pattern_ftype(pattern, filetype)
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = pattern,
    callback = function() vim.bo.filetype = filetype end,
  })
end

pattern_ftype('*.glslv,*.glslf', 'glsl')
pattern_ftype('*_armv8.s,*_armv8.S', 'arm')
pattern_ftype('*.v', 'verilog')
pattern_ftype('*.jl', 'julia')
pattern_ftype('*.typ', 'typst')

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {on_visual = false, timeout = 200}
  end
})

-- less aggressive highlighting
vim.cmd [[
highlight clear Identifier
highlight clear Constant
highlight clear LspDiagnosticsUnderlineHint
]]
