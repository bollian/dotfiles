local o = vim.o
local wo = vim.wo
local bo = vim.bo

local function merge_into(target, extras)
  for key, value in pairs(extras) do
    target[key] = value
  end
end

-- vim.g.floaterm_shell = 'nu'
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
  -- shell = 'nu', -- use a specific default shell (this breaks fugitive)

  -- exrc = true,
})

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
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'disable',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,

  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' }
  }, {
    { name = 'tags' }
  }),

  source = {
    path = true,
    buffer = true,
    calc = true,
    nvim_lsp = true,
    nvim_lua = true,
    vsnip = true,
  },

  mapping = {
    ['<Tab>'] = function(fallback)
      local cmp = require 'cmp'
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end
  }
}

require'kommentary.config'.configure_language('default', {
  prefer_single_line_comments = true,
})

require'nvim-autopairs'.setup()

require'neoclip'.setup{}

require 'nvim-gps'.setup {
  -- icons = {
  --   ['class-name'] = 'C ',
  --   ['function-name'] = 'f ',
  --   ['method-name'] = 'm ',
  --   ['container-name'] = 'n ',
  --   ['tag-name'] = 't ',
  -- }
}
