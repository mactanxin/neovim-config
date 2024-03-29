local options = {
  foldmethod = "syntax",
  foldcolumn = "1",
  foldlevel = 99,
  foldlevelstart = 99,
  foldenable = true,
  syntax = "on",
  fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
  autochdir = true,
  ruler = true,
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 4,                           -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  timeout = true,
  timeoutlen = 900,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  shiftround = true,
  autowrite = true,
  softtabstop = 2,
  autoindent = true,
  tabstop = 2,           -- insert 2 spaces for a tab
  cursorline = true,     -- highlight the current line
  number = true,         -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4,       -- set number column width to 2 {default 4}
  signcolumn = "yes",    -- always show the sign column, otherwise it would shift the text each time
  columns = 60,
  textwidth = 60,
  wrap = true,   -- display lines as one long line
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  copyindent = true,
  lazyredraw = false,
  -- guifont = "MesloLGS  NF:h16",               -- the font used in graphical neovim applications
  guifont = "DejaVuSansMono Nerd Font Mono:h18", -- the font used in graphical neovim applications
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

local o = vim.o

o.statusline = ""
o.statusline = o.statusline .. "%f"
-- o.fillchars = o.fillchars .. 'diff:'

if vim.fn.has("termguicolors") == 1 then
  vim.opt.termguicolors = true
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
