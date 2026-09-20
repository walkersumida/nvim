return {
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>mo", "<cmd>Outline<cr>", desc = "Toggle markdown/code outline" },
    },
    opts = {
      outline_window = {
        position = "right",
        width = 30,
        relative_width = true,
        auto_close = false,
        -- Jumping from the outline keeps it open so the list stays usable as a map.
        auto_jump = false,
      },
      outline_items = {
        show_symbol_details = false,
      },
      symbol_folding = {
        autofold_depth = false,
      },
      preview_window = { auto_preview = false },
      providers = {
        -- The markdown provider parses headings directly, so no LSP server is required.
        priority = { "markdown", "lsp" },
      },
    },
  },
}
