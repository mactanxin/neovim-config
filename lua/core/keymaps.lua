local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, silent = true, expr = true }
local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
keymap("", ";", ":", opts)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function mapkey(mode, lhs, rhs)
  vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true })
end

local function mapcmd(key, cmd)
  vim.api.nvim_set_keymap("n", key, ":" .. cmd .. "<cr>", { noremap = true })
end

local function maplua(key, txt)
  vim.api.nvim_set_keymap("n", key, ":lua " .. txt .. "<cr>", { noremap = true })
end

local function is_available(plugin)
  return packer_plugins ~= nil and packer_plugins[plugin] ~= nil
end

local function toast(msg, level)
  vim.notify(msg, level, {
    title = "My custom notification",
    timeout = 5000,
  })
end

vim.cmd([[

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
]])
--Remap space as leader key
--
mapcmd("s", "<Nop>")
mapcmd("S", "<Nop>")
mapcmd("R", "<Nop>")
mapcmd("<LEADER><CR>", "noh")
mapcmd("<Leader>O", "%bd|e#|bd#")

mapcmd("<LEADER>d", "Alpha")

mapkey("n", "<LEADER>m", ":call mkdir(expand('%:p:h'), 'p')<CR>")
mapkey("n", "<LEADER>f", "<Plug>(coc-format-selected)")
mapkey("v", "<LEADER>f", "<Plug>(coc-format-selected)")

mapkey("n", "[b", ":bprevious<CR>")
mapkey("n", "]b", ":bnext<CR>")
mapkey("n", "[B", ":bfirst<CR>")
mapkey("n", "]B", ":blast<CR>")

mapkey("n", "+", "<C-a>")
mapkey("n", "-", "<C-x>")

mapkey("x", "<leader>o", '"_dP')
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--
keymap(
  "n",
  "S",
  ":w<CR> :lua vim.notify('Save Complete', 'info', { title = 'User Operation', timeout = 1000, stages = 'fade_in_slide_out'})<CR>",
  opts
)
--select all text
keymap("n", '<C-a>', "gg<S-v>G", opts)
keymap("n", "Q", ":q<CR>", opts)
keymap("n", "Z", ":q!<CR>", opts)
mapcmd("R", "ReloadConfig<CR>")
keymap("", "cd", ":chdir", opts)

-- Visual --
-- Stay in indent mode
if is_available("Comment.nvim") then
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)
end

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- -- Toggle NERDTree
mapcmd("tt", ":NeoTreeShowToggle")
mapcmd("<LEADER>r", ":NvimTreeRefresh")
keymap("n", "<LEADER>p", ":w | !open %<CR>", opts) -- live preview files using dufault App

-- jump back and forth in frames
mapkey("n", "<C-l>", "<C-w>l")
mapkey("n", "<C-h>", "<C-w>h")
mapkey("n", "<C-j>", "<C-w>j")
mapkey("n", "<C-k>", "<C-w>k")
mapkey("n", "<LEADER><LEADER>", "<C-f>")
mapkey("n", "<LEADER>bb", "<C-b>")
mapkey("n", ";sv", "<C-w>t<C-w>H<CR>")
mapkey("n", ";sh", "<C-w>t<C-w>K<CR>")

-- Comment
maplua("<LEADER>/", 'require("Comment.api").locked("toggle.linewise.current")()')
keymap(
  "v",
  "<LEADER>/",
  '<esc><cmd>lua require("Comment.api").locked("comment.linewise")(vim.fn.visualmode())<CR>',
  opts
)
vim.keymap.set("n", "<leader>sr", "", {
  silent = true,
  desc = "reload init.lua",
  callback = function()
    vim.cmd([[
      source $MYVIMRC
    ]])
    vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, { title = "nvim-config" })
  end,
})

keymap("", "<LEADER>cd", ":cd %:p:h<CR>:pwd<CR>", opts)
mapcmd("<LEADER>ss", ":SaveSession")
mapcmd("<LEADER>sl", ":RestoreSession")

-- GoTo Tabs by number
keymap("", "<LEADER>1", "1gt", opts)
keymap("", "<LEADER>2", "2gt", opts)
keymap("", "<LEADER>3", "3gt", opts)
keymap("", "<LEADER>4", "4gt", opts)
keymap("", "<LEADER>5", "5gt", opts)
keymap("", "<LEADER>6", "6gt", opts)
keymap("", "<LEADER>7", "7gt", opts)
keymap("", "<LEADER>8", "8gt", opts)
keymap("", "<LEADER>9", "9gt", opts)
keymap("", "<LEADER>9", "9gt", opts)
keymap("", "<LEADER>0", ":tablast<CR>", opts)

-- split
mapcmd("<leader>sl", "set splitright<CR>:vsplit<CR>")
mapcmd("<leader>sh", "set nosplitright<CR>:vsplit<CR>")
mapcmd("<leader>sk", "set splitbelow<CR>:split<CR>")
mapcmd("<leader>sj", "set splitbelow<CR>:split<CR>")

-- change split size using alt+arrow
mapcmd("<M-left>", "vertical resize -5<cr>")
mapcmd("<M-down>", "resize +5<cr>")
mapcmd("<M-up>", "resize -5<cr>")
mapcmd("<M-right>", "vertical resize +5<cr>")

mapcmd("tn", "tabe")
mapcmd("th", "-tabnext")
mapcmd("tl", "+tabnext")

mapkey("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
mapkey("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
mapkey("n", "<leader>fc", "<cmd>Telescope git_commits<CR>")
mapkey("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
mapkey("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
mapkey("n", "<leader>ft", "<cmd>Telescope notify<cr>")
maplua("<leader>fs", "require('session-lens').search_session()")
mapkey("n", "<leader>fe", "<cmd>Telescope file_browser<cr>")
mapkey("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>")
mapkey("n", "<leader>lso", "<cmd>Lspsaga outline<CR>")
vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
-- telescope git commands
mapkey("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
mapkey("n", "<leader>gbc", "<cmd>Telescope git_bcommits<cr>", opts)
mapkey("n", "<leader>gbr", "<cmd>Telescope git_branches<cr>", opts)
mapkey("n", "<leader>gst", "<cmd>Telescope git_status<cr>", opts)
--[[ maplua("<leader>fs", "require('session-lens').search_session()") ]]
maplua("<leader>cn", "require('notify').dismiss()<cr>", opts)
-- SarchBox Key Bindings
mapcmd("<LEADER>rs", "SearchBoxIncSearch")
mapcmd("<LEADER>rr", "SearchBoxReplace confirm=menu")

-- EasyMotion
keymap("n", "s", "<Plug>(easymotion-bd-f)", opts)

-- EasyAlign
mapcmd("ga", ":EasyAlign<CR>", opts)

-- Diff View
mapcmd("<LEADER>df", ":DiffviewOpen<CR>")

-- PeepSight
mapcmd("<LEADER>pp", ":Peepsight<CR> :lua vim.notify('Peepsight toggled', 'info', { title = 'PeepSight Plugin' })<cr>")

mapcmd("<LEADER>ch", ":ColorHighlight<CR>")
mapkey("n", "<leader>rn", "<Plug>(coc-rename)<cr>", opts)
mapkey("n", "<leader>ew", "<C-w>r<cr>")
mapcmd("<LEADER>fm", ":lua vim.lsp.buf.formatting()<cr>")
--[[ mapkey("n", "<Leader>", ":WhichKey\r<leader>", opts) ]]
-- toggle null-ls
mapkey("n", "<leader>tn", ":lua require('null-ls').toggle({})<cr>")
-- LazyGit
mapcmd("<leader>lg", ":LazyGit")

-- TreeSJ
mapcmd("T", ":TSJToggle<CR>")

-- Lsp_lines
mapkey("n", "<leader>ll", ":lua require('lsp_lines').toggle<cr>")
