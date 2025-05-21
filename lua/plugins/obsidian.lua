return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter",
    "MeanderingProgrammer/render-markdown.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = os.getenv("OBSIDIAN_WORKSPACE_PATH") or "",
      },
    },
    note_id_func = function(title)
      local date = os.date("%Y-%m-%d")
      if title ~= nil then
        return date .. "_" .. title:gsub(" ", "_")
      else
        return date
      end
    end,
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
    attachments = {
      img_folder = "assets/images",

      ---@return string
      img_name_func = function()
        return string.format("%s", os.date("%Y%m%d%H%M%S"))
      end,
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show backlinks" })
    vim.keymap.set("n", "<leader>ot", function()
      local tag = vim.fn.input("Tags: ")
      if tag ~= "" then
        vim.cmd("ObsidianTags " .. tag)
      end
    end, { desc = "Prompt for a tag and run :ObsidianTags [TAG ...]" })
    vim.keymap.set("n", "<leader>or", "<cmd>ObsidianRename<CR>", { desc = "Rename file" })
    vim.keymap.set("n", "<leader>oc", function()
      local name = vim.fn.input("Name: ")
      if name ~= "" then
        vim.cmd("ObsidianNew " .. name)
      end
    end, { desc = "Prompt for a name and run :ObsidianNew [NAME]" })
    vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show links" })
  end,
}
