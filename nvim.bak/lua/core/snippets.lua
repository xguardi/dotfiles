--
-- [[ Custom code snippets for different purposes ]]
--

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Insert current date with <leader>d
local function insert_date()
    local date = os.date("%d-%m-%Y") 
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, line - 1, col, line - 1, col, { date })
end
-- Make the function globally accessible
_G.insert_date = insert_date
-- Map
vim.api.nvim_set_keymap('n', '<leader>dt', ':lua insert_date()<CR>', { desc = "[P] Insert date", noremap = true, silent = true })
