-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights and close floating windows on search when
-- pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR><cmd>fclose<CR>', { silent = true })

vim.keymap.set('n', '<leader>j', ":bnext<enter>", { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>k', ":bprev<enter>", { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', ":bdelete<enter>", { desc = 'Delete buffer' })

-- Alt-v for visual block mode instead of Ctrl-v
vim.keymap.set('n', '<A-v>', '<C-v>', { noremap = true })

-- Cycle the visibility of the gutter (sign column) and line numbers
local linenum_state = {
  number = true,
  relativenumber = false,
}

vim.keymap.set('n', '<leader>tg', function()
  if vim.o.number or vim.o.relativenumber then
    linenum_state.number = vim.o.number
    linenum_state.relativenumber = vim.o.relativenumber
    if vim.o.signcolumn == 'no' then
      vim.o.signcolumn = 'yes'
    else
      vim.o.signcolumn = 'no'
      vim.o.number = false
      vim.o.relativenumber = false
    end
  else
    vim.o.signcolumn = 'no'
    vim.o.number = linenum_state.number
    vim.o.relativenumber = linenum_state.relativenumber
  end
end, { desc = '[T]oggle [G]utter + Line Numbers' })

-- -- Resize splits with Alt + hjkl or arrow keys
-- local resize_mappings = {
--   {
--     keys = { '<M-k>', '<M-Up>' },
--     cmd = 'resize +1',
--     desc = 'Resize: height+'
--   },
--   {
--     keys = { '<M-j>', '<M-Down>' },
--     cmd = 'resize -1',
--     desc = 'Resize: height-'
--   },
--   {
--     keys = { '<M-l>', '<M-Right>' },
--     cmd = 'vertical resize +1',
--     desc = 'Resize: width+'
--   },
--   {
--     keys = { '<M-h>', '<M-Left>' },
--     cmd = 'vertical resize -1',
--     desc = 'Resize: width-'
--   },
-- }
--
-- for _, mapping in ipairs(resize_mappings) do
--   for _, key in ipairs(mapping.keys) do
--     vim.keymap.set('n', key, ':' .. mapping.cmd .. '<CR>', { desc = mapping.desc })
--   end
-- end

-- Diagnostic keymaps
vim.keymap.set('n', 'öd', function() vim.diagnostic.jump { count = -1, float = false } end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', 'äd', function() vim.diagnostic.jump { count = 1, float = false } end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })
--

-- Disable select mode keymaps
vim.keymap.set({"x", "s"}, "<C-g>", "<nop>", { silent = true }) -- Ctrl-g
vim.keymap.set("n", "gh", "<nop>") -- start Select mode (charwise)
vim.keymap.set("n", "gH", "<nop>") -- linewise Select mode
vim.keymap.set("n", "g<C-h>", "<nop>") -- blockwise Select

-- Paste over currently selected text without yanking it
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = '[p]aste over without yanking' })
-- Delete into void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = '[d]elete without yanking' })

-- Yank only to system clipboard (do not modify unnamed register)
vim.keymap.set({"n","v"}, "<leader>y", function()
  local unnamed = vim.fn.getreg('"')
  local unnamed_type = vim.fn.getregtype('"')

  vim.cmd('normal! "+y')

  vim.fn.setreg('"', unnamed, unnamed_type)
end, { silent = true, desc = '[y]ank to system clipboard' })

vim.keymap.set("n", "<leader>Y", function()
  local unnamed = vim.fn.getreg('"')
  local unnamed_type = vim.fn.getregtype('"')

  vim.cmd('normal! "+Y')

  vim.fn.setreg('"', unnamed, unnamed_type)
end, { silent = true, desc = '[Y]ank line to system clipboard' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
