return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- must load at startup to take over directory buffers (e.g. `nvim .`)
    keys = {
      { "-", function() require("oil").open() end, desc = "Open parent directory" },
    },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
}
