-- Markdown is deliberately left unformatted: how-to.md relies on
-- hand-aligned columns and prettier would reflow them.
return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        go = { "gofmt" },
        rust = { "rustfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- ruff_format, gofmt and rustfmt come from ruff/go/rust toolchains.
      -- Mason only needs to provide stylua and prettier.
      local ok, registry = pcall(require, "mason-registry")
      if not ok then
        return
      end
      registry.refresh(function()
        for _, name in ipairs({ "stylua", "prettier" }) do
          local pkg_ok, pkg = pcall(registry.get_package, name)
          if pkg_ok and not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
    end,
  },
}
