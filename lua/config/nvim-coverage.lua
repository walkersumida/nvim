local M = {}

function M.setup()
  require("coverage").setup({
    signs = {
      -- use your own highlight groups or text markers
      covered = { hl = "CoverageCovered", text = "█" },
      uncovered = { hl = "CoverageUncovered", text = "█" },
    },
  })
end

return M
