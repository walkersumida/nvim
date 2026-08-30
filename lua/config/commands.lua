local M = {}

function M.setup()
  vim.api.nvim_create_user_command("CopyFilePath", function()
    vim.fn.setreg("*", vim.fn.expand("%:p"))
  end, {})

  vim.api.nvim_create_user_command("CopyFilePathWithLine", function()
    local filepath = vim.fn.expand("%:p")
    local linenum = vim.fn.line(".")
    local full = string.format("%s:%dL", filepath, linenum)
    vim.fn.setreg("*", full)
  end, {})

  vim.api.nvim_create_user_command("CopyPath", function()
    vim.fn.setreg("*", vim.fn.expand("%:h"))
  end, {})

  vim.api.nvim_create_user_command("CopyFileName", function()
    vim.fn.setreg("*", vim.fn.expand("%:t"))
  end, {})

  vim.api.nvim_create_user_command("EncodeSJIS", function()
    vim.cmd("e ++enc=sjis")
  end, {})

  vim.api.nvim_create_user_command("SaveWithoutFormatting", function()
    vim.cmd("noa w")
  end, {})

  vim.api.nvim_create_user_command("DeleteCurrentFile", function()
    local filepath = vim.fn.expand("%:p")
    if filepath == "" then
      vim.notify("No file associated with this buffer", vim.log.levels.WARN)
      return
    end
    if vim.fn.confirm("Delete " .. filepath .. "?", "&Yes\n&No", 2) ~= 1 then
      return
    end
    if vim.fn.delete(filepath) ~= 0 then
      vim.notify("Failed to delete: " .. filepath, vim.log.levels.ERROR)
      return
    end
    vim.cmd("Bclose")
  end, {})
end

return M
