-- 
-- [[ xguardi's neovim config file ]]
--

-- Load modules
require 'core.options'
require 'core.keymaps'
require 'core.snippets'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

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
require("lazy").setup({
  require 'plugins.catpuccin',
  require 'plugins.telescope',
  require 'plugins.treesitter',
  require 'plugins.gitsigns',
  require 'plugins.which-key',
  require 'plugins.vim-tmux-navigator',
  require 'plugins.lualine',
})

-- local plugins = {
--   { 'jpalardy/vim-slime' },
--   { "iamcco/markdown-preview.nvim",
--     cmd = {"MarkdownPreview", "MarkdownPreviewStop"},
--     lazy = false,
--     build = function() vim.fn["mkdp#util#install"]() end, },
--   { "nvim-lualine/lualine.nvim", dependencies = { 'nvim-tree/nvim-web-devicons' }},

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
