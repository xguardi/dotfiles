-- Nvim 0.11+ pattern: vim.lsp.config()/vim.lsp.enable(), not
-- require('lspconfig').<server>.setup{}. mason-lspconfig (mason-org/*)
-- installs servers and calls vim.lsp.enable() for them automatically.
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      {
        "mason-org/mason-lspconfig.nvim",
        opts = function()
          local servers = {
            "lua_ls",
            "pyright",
            "ruff",
            "ts_ls",
            "bashls",
            "gopls",
            "rust_analyzer",
            "marksman",
          }
          return {
            ensure_installed = servers,
            -- Without this, automatic_enable also LSP-enables any other
            -- installed Mason package that ships an lspconfig server
            -- definition (e.g. `stylua --lsp`, installed here as a plain
            -- CLI formatter for conform.nvim).
            automatic_enable = servers,
          }
        end,
      },
    },
    config = function()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Goto definition")
          map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
          map("n", "gr", vim.lsp.buf.references, "Goto references")
          map("n", "gI", vim.lsp.buf.implementation, "Goto implementation")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        end,
      })
    end,
  },
}
