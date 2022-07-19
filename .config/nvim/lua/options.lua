local function merge_into(target, extras)
  for key, value in pairs(extras) do
    target[key] = value
  end
end

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

merge_into(vim.opt, {
  guifont = 'UbuntuMono Nerd Font Mono:h15', -- set the font when using a graphical interface
  mouse = 'a', -- support mouse selection, clicking, etc
  textwidth = 0, -- no automatic word-wrapping
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

require'telescope'.setup {}

require'nvim-lightbulb'.update_lightbulb {
  sign = {
    enabled = true,
    -- Priority of the gutter sign
    priority = 100,
    text = 'A'
  },
  float = {
    enabled = true,
    -- Text to show in the popup float
    text = "A",
    win_opts = {},
  },
  virtual_text = {
    enabled = false,
    -- Text to show at virtual text
    text = "A",
  }
}

local cmp = require 'cmp'
cmp.setup {
  sources = cmp.config.sources({
    -- highest priority sources
    { name = 'nvim_lsp' },
  }, {
    -- next priority sources. not shown if higher priority is available
    { name = 'buffer' },
  }),
  view = {
    entries = 'native',
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
}

-- enable buffer source for / search
cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
    { name = 'buffer' },
  })
})

require 'Comment'.setup {}

require'nvim-autopairs'.setup {}

require'neoclip'.setup {}

require 'nvim-gps'.setup {}

require 'auto-session'.setup {}
