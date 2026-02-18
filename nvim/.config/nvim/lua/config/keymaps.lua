-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Generate PDF from markdown
vim.api.nvim_create_user_command("Md2Pdf", function()
  local file = vim.fn.expand(vim.fn.shellescape("%"))
  local out = vim.fn.expand(vim.fn.shellescape("%:r")) .. ".pdf"

  vim.cmd(
    string.format("!pandoc %s -o %s --pdf-engine=weasyprint --css=$HOME/dotfiles/styles/pdf_styles.css", file, out)
  )
end, { desc = "Markdown → HTML-style PDF" })

vim.keymap.set("n", "<leader>mp", "<cmd>Md2Pdf<CR>", {
  desc = "Export Markdown to PDF",
})

-- Insert current date in Spanish format (DD-MM-YYYY)
vim.keymap.set("n", "<leader>D", function()
  vim.api.nvim_put({ os.date("%d-%m-%Y") }, "c", true, true)
end, { desc = "Insert date (DD-MM-YYYY)" })
