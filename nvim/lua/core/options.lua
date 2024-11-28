-- 
-- [[ Settings ]]
-- 
-- For more options, you can see `:help option-list`
--
-- To display a specific option value (number for example)
-- :lua =vim.o.number

vim.opt.number = true -- Line number (default: false)
vim.opt.wrap = false -- Display lines as one long line (default: true)
vim.opt.linebreak = true -- Companion to wrap, don't split words (default: false)
vim.opt.shiftwidth = 2 -- The number of spaces inserted for each indentation (default: 8)
vim.opt.tabstop = 2 -- Insert n spaces for a tab (default: 8)
vim.opt.softtabstop = 2 -- Number of spaces that a tab counts for while performing editing operations (default: 0)
vim.opt.expandtab = true -- Convert tabs to spaces (default: false)
vim.opt.autoindent = true -- Indent a new line the same amount as the line just typed
vim.opt.smartindent = true -- Adds additional logic to increase or decrease the level of indentation based on the syntax of the code (default: false)
vim.opt.cursorline = true -- Show cursor line
vim.opt.scrolloff = 4 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
vim.opt.mouse = 'a' -- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.showmode = false -- We don't need to see things like -- INSERT -- anymore (default: true)
vim.opt.swapfile = false -- Creates a swapfile (default: true)
vim.opt.undofile = true -- Save undo history (default: false)

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true -- If your search pattern contains any uppercase letters, the search becomes case-sensitive (default: false)
vim.opt.iskeyword:append '-' -- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time. Displays which-key popup sooner
vim.opt.splitright = true -- -- Force all vertical splits to go to the right of current window (default: false)
vim.opt.splitbelow = true -- Force all horizontal splits to go below current window (default: false)

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.conceallevel = 2 -- Enable conceals (md links, etc.)
