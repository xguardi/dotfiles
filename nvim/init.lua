-- 
-- [[ xguardi's neovim config file ]]
--

-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Settings ]]
-- For more options, you can see `:help option-list`

-- Enable line number
vim.opt.number = true

-- width of tab
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
-- use number of spaces to insert <Tab>
vim.opt.expandtab = true
-- indent a new line the same amount as the line just typed
vim.opt.autoindent = true

-- show cursor line
vim.opt.cursorline = true

-- start scrolling a few lines before the bottom line
vim.opt.scrolloff = 5

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Enable conceals (md links, etc.)
vim.opt.conceallevel = 2

-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- map leader+y to copy to system clipboard in normal and visual mode
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

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

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
local plugins = {
	{ 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  { 'lewis6991/gitsigns.nvim' },
  { 'folke/which-key.nvim' },
  { 'jpalardy/vim-slime' },
  { 'christoomey/vim-tmux-navigator',
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
      keys = {
        { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
        { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
        { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
        { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
        { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      },
  }
--   { "iamcco/markdown-preview.nvim",
--     cmd = {"MarkdownPreview", "MarkdownPreviewStop"},
--     lazy = false,
--     build = function() vim.fn["mkdp#util#install"]() end, },
--   { "nvim-lualine/lualine.nvim", dependencies = { 'nvim-tree/nvim-web-devicons' }},
--   { "nvim-treesitter/nvim-treesitter",
--     run = ":TSUpdate",
--     config = function ()
--       require("nvim-treesitter.configs").setup({
--         ensure_installed = { "markdown", "markdown_inline", "r", "rnoweb" },
--       })
--     end },
--   -- vim-slime sending text to REPL
--   -- Comments
--   {'numToStr/Comment.nvim',
--     opts = {
--         -- add any options here
--     }
--   }
}
local opts = {}
require("lazy").setup(plugins, opts)

-- Set color scheme
require("catppuccin").setup()
vim.cmd.colorscheme 'catppuccin'

-- -- Statusline
-- -- overwritting the default config
-- require('lualine').setup {
--   options = {
--       component_separators = '|',
--       section_separators = { left = '', right = '' }
--   },
--   sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'branch', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   }
-- }

-- [[ Telescope ]]

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>h', builtin.help_tags, {})

-- [[ Treesitter ]]

local config = require('nvim-treesitter.configs')
config.setup({
    ensure_installed = { "c", "css", "lua", "vim", "vimdoc", "query", "r", "python", "javascript", "html" },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})

-- [[ Gitsigns ]]

require('gitsigns').setup {
  signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      }
}

-- [[ Which-key]]

require('which-key').setup {
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      }
    }
}

-- [[ vim-slime ]]

-- vim.g.slime_target = 'tmux'
-- -- vim.g.slime_default_config = {"socket_name" = "default", "target_pane" = "{last}"}
-- vim.g.slime_default_config = {
--   -- Lua doesn't have a string split function!
--   socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)'),
--   target_pane = '{right}',
-- }
--
-- -- View current file in browser (or the right app)
-- vim.keymap.set('n', '<leader>b', ':!open %<CR>')
--
-- -- Custom stuff
--
-- -- Shortcuts
-- vim.api.nvim_set_keymap('n', '<leader>h', ':e ~/paperets/howto/<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>v', ':e ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
--
-- -- Insert current date with <leader>d
-- local function insert_date()
--     local date = os.date("%d-%m-%Y") 
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     vim.api.nvim_buf_set_text(0, line - 1, col, line - 1, col, { date })
-- end
-- -- Make the function globally accessible
-- _G.insert_date = insert_date
-- -- Map
-- vim.api.nvim_set_keymap('n', '<leader>d', ':lua insert_date()<CR>', { noremap = true, silent = true })
--
-- -- Function to reload the Neovim configuration
-- local function reload_config()
--     for name, _ in pairs(package.loaded) do
--         if name:match('^user_conf') then
--             package.loaded[name] = nil
--         end
--     end
--     dofile(vim.fn.stdpath('config') .. '/init.lua')
--     print("Configuration reloaded!")
-- end
-- -- Map
-- vim.api.nvim_create_user_command('ReloadConfig', reload_config, {})
-- vim.api.nvim_set_keymap('n', '<leader>V', ':ReloadConfig<CR>', { noremap = true, silent = true })
