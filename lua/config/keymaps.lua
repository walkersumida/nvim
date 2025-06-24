local M = {}

function M.setup()
  -- Save
  vim.keymap.set("n", "<leader>w", ":w!<CR>")

  -- Clear highlight
  vim.keymap.set("n", "<leader><CR>", ":noh<CR>", { silent = true })

  -- Visual paste (p)
  vim.keymap.set("x", "p", "pgvy")

  -- Execute macro @q
  vim.keymap.set("n", "<C-.>", "@q")

  -- Move visual lines
  vim.keymap.set({ "n", "v" }, "j", "gj")
  vim.keymap.set({ "n", "v" }, "k", "gk")
  vim.keymap.set({ "n", "v" }, "<Down>", "gj")
  vim.keymap.set({ "n", "v" }, "<Up>", "gk")

  -- Terminal keymaps
  local function set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set("t", "<C-\\>", [[<C-\><C-n>]], opts)
  end

  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = set_terminal_keymaps,
  })

  vim.keymap.set("n", "sh", ":<C-u>sp<CR>")
  vim.keymap.set("n", "sv", ":<C-u>vs<CR>")
  vim.keymap.set("n", "x", '"_x')
  vim.keymap.set("n", "ZZ", ":qa<CR>")

  vim.keymap.set("i", "<C-p>", "<C-c>gka")
  vim.keymap.set("i", "<C-n>", "<C-c>gja")
  vim.keymap.set("i", "<C-l>", "<C-o>zz")
  vim.keymap.set("i", "jj", "<ESC>")

  vim.keymap.set("v", "x", '"_x')

  vim.keymap.set({ "i", "c" }, "<C-b>", "<Left>")
  vim.keymap.set({ "i", "c" }, "<C-f>", "<Right>")
  vim.keymap.set({ "i", "c" }, "<C-e>", "<End>")
  vim.keymap.set({ "i", "c" }, "<C-a>", "<Home>")
  vim.keymap.set({ "i", "c" }, "<C-d>", "<Del>")
  vim.keymap.set({ "i", "c" }, "<C-k>", "<C-o>D")
  vim.keymap.set({ "i", "c" }, "<C-y>", '<C-r>"')

  vim.keymap.set("n", "<C-j>", "<C-W>j")
  vim.keymap.set("n", "<C-k>", "<C-W>k")
  vim.keymap.set("n", "<C-h>", "<C-W>h")
  vim.keymap.set("n", "<C-l>", "<C-W>l")

  -- Ctrl+G: Show file info and copy file path with line number
  vim.keymap.set("n", "<C-g>", function()
    -- Execute CopyFilePathWithLine command
    vim.cmd("CopyFilePathWithLine")

    -- Execute default Ctrl+G behavior - show file info
    local line = vim.fn.line(".")
    local total_lines = vim.fn.line("$")
    local percent = math.floor((line / total_lines) * 100)
    print(
      string.format('"%s" %d lines --%d%%-- %d,%d All', vim.fn.expand("%"), total_lines, percent, line, vim.fn.col("."))
    )
  end)
end

return M
