return {
  {
    "linrongbin16/gitlinker.nvim",
    cmd = { "GitLink", "GitLinkCurrentBranch" },
    opts = {},
    keys = {},
    config = function()
      require("gitlinker").setup({
        router = {
          browse = {
            ["^ssh%.github%.com$"] = "https://github.com/"
              .. "{_A.ORG}/{_A.REPO}/blob/{_A.REV}/"
              .. "{_A.FILE}?plain=1"
              .. "#L{_A.LSTART}"
              .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          },
          blame = {
            ["^ssh%.github%.com$"] = "https://github.com/"
              .. "{_A.ORG}/{_A.REPO}/blame/{_A.REV}/"
              .. "{_A.FILE}?plain=1"
              .. "#L{_A.LSTART}"
              .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          },
          current_branch = {
            ["^ssh%.github%.com$"] = "https://github.com/"
              .. "{_A.ORG}/{_A.REPO}/blob/{_A.CURRENT_BRANCH}/"
              .. "{_A.FILE}?plain=1"
              .. "#L{_A.LSTART}"
              .. "{(_A.LEND > _A.LSTART and ('-L' .. _A.LEND) or '')}",
          },
        },
      })
      vim.api.nvim_create_user_command("GitLinkCurrentBranch", function()
        require("gitlinker").link({ router_type = "current_branch" })
      end, { range = true })
    end,
  },
}
