-- `main`'s tip now requires Nvim 0.12/nightly (dropped 0.11 support in
-- 2026-04); pin to the last commit known to run on stable 0.11.x instead of
-- floating on `main` or falling back to the archived, unmaintained `master`
-- branch (whose frozen queries drift out of sync with upstream grammars).
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    commit = "19c729dae6e0eeb79423df0cf37780aa9a7cc3b7",
    build = ":TSUpdate",
    lazy = false, -- this plugin does not support lazy-loading
    config = function()
      local ensure_installed = {
        "lua",
        "python",
        "javascript",
        "typescript",
        "tsx",
        "markdown",
        "markdown_inline",
        "bash",
        "go",
        "rust",
        "vim",
        "vimdoc",
      }

      require("nvim-treesitter").install(ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "lua",
          "python",
          "javascript",
          "typescript",
          "typescriptreact",
          "markdown",
          "sh",
          "bash",
          "go",
          "rust",
          "vim",
          "help",
        },
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  },
}
