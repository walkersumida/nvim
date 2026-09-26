local bookmarks_file = vim.fn.stdpath("data") .. "/oil-bookmarks.txt"

local function read_bookmarks()
  if vim.fn.filereadable(bookmarks_file) == 0 then
    return {}
  end
  return vim.tbl_filter(function(line)
    return line ~= ""
  end, vim.fn.readfile(bookmarks_file))
end

local function add_bookmark()
  local dir = require("oil").get_current_dir()
  if not dir then
    return
  end
  if vim.tbl_contains(read_bookmarks(), dir) then
    vim.notify("Already bookmarked: " .. dir)
    return
  end
  vim.fn.writefile({ dir }, bookmarks_file, "a")
  vim.notify("Bookmarked: " .. dir)
end

local function pick_bookmarks()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local conf = require("telescope.config").values
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Oil bookmarks (<C-e>: edit list)",
      finder = require("telescope.finders").new_table({
        results = read_bookmarks(),
        entry_maker = function(dir)
          local display = vim.fn.fnamemodify(dir, ":~")
          return { value = dir, display = display, ordinal = display }
        end,
      }),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          local entry = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          if entry then
            require("oil").open(entry.value)
          end
        end)
        map({ "i", "n" }, "<C-e>", function()
          actions.close(prompt_bufnr)
          vim.cmd.edit(vim.fn.fnameescape(bookmarks_file))
        end)
        return true
      end,
    })
    :find()
end

return {
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
      { "<leader>-", "<cmd>vsplit | Oil<cr>", desc = "Open parent directory in a vertical split" },
      { "<leader>fo", pick_bookmarks, desc = "Oil bookmarks" },
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
        ["gb"] = { callback = add_bookmark, desc = "Add current dir to bookmarks", mode = "n" },
        ["<leader>y"] = { "actions.copy_to_system_clipboard", mode = "n" },
        ["<leader>p"] = { "actions.paste_from_system_clipboard", mode = "n" },
      },
    },
  },
}
