return {
  {
    "linrongbin16/gitlinker.nvim",
    cmd = { "GitLink", "GitLinkCurrentBranch" },
    opts = {},
    keys = {},
    config = function()
      require("gitlinker").setup()
      vim.api.nvim_create_user_command("GitLinkCurrentBranch", function()
        require("gitlinker").link({ router_type = "current_branch" })
      end, { range = true })
    end,
  },
}
