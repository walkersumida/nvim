-- Markdown specific indentation settings
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local o = vim.opt_local
    o.wrap = true
    o.linebreak = true
    o.breakindent = true
    o.breakindentopt = "shift:2"
  end,
})
