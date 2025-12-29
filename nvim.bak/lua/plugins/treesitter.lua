return { 
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local config = require('nvim-treesitter.configs')
    config.setup({
      ensure_installed = { 
        "bash", 
        "c", 
        "css", 
        "gitignore",
        "html",
        "javascript",
        "json",
        "java",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "sql",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
