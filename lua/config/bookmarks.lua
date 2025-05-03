local M = {}

function M.setup()
  require('bookmarks').setup {
    -- sign_priority = 8,  --set bookmark sign priority to cover other sign
    save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
    keywords = {
      ["@t"] = "✅", -- mark annotation startswith @t ,signs this icon as `Todo`
      ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
      ["@f"] = "🧰", -- mark annotation startswith @f ,signs this icon as `Fix`
      ["@n"] = "💬", -- mark annotation startswith @n ,signs this icon as `Note`
      ["@i"] = "💬", -- mark annotation startswith @i ,signs this icon as `Info`
    },
    on_attach = function(bufnr)
      local bm = require "bookmarks"
      local map = vim.keymap.set
      map("n", "<leader>mm", bm.bookmark_ann)   -- add or edit mark annotation at current line
      map("n", "<leader>mt", bm.bookmark_toggle) -- add or remove bookmark at current line
      map("n", "<leader>mc", bm.bookmark_clean) -- clean all marks in local buffer
      map("n", "<leader>mn", bm.bookmark_next)  -- jump to next mark in local buffer
      map("n", "<leader>mp", bm.bookmark_prev)  -- jump to previous mark in local buffer
      map("n", "<leader>ml", bm.bookmark_list)  -- show marked file list in quickfix window
      map("n", "<leader>mx", bm.bookmark_clear_all) -- removes all bookmarks
    end
  }
end

return M
