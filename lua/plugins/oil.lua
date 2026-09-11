return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>-", "<cmd>vsplit | Oil<cr>", desc = "Open parent directory in a vertical split" },
    },
    opts = {
      delete_to_trash = true,
      watch_for_changes = true,
      view_options = { show_hidden = true },
      keymaps = {
        -- Keep <C-h>/<C-l> for window navigation
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["gp"] = {
          callback = function()
            local shown = vim.tbl_contains(require("oil.config").columns, "permissions")
            require("oil").set_columns(shown and { "icon" } or { "icon", "permissions" })
          end,
          desc = "Toggle permissions column",
          mode = "n",
        },
        ["gy"] = { "actions.yank_entry", mode = "n" },
        ["<leader>y"] = { "actions.copy_to_system_clipboard", mode = "n" },
        ["<leader>p"] = { "actions.paste_from_system_clipboard", mode = "n" },
      },
    },
  },
}
