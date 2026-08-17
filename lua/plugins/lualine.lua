-- lualine emits Vim's `%<` truncation marker at the head of the first section
-- after b, so section b is never shortened to fit the window. A long filename
-- there would push the sections behind it off the right edge, so cap it here.
local function name_limit()
  local width = vim.fn.winwidth(0)
  -- Vim exposes the truly focused window as g:actual_curwin while a statusline
  -- is evaluated for another window; lualine sets it during its own refresh.
  if tonumber(vim.g.actual_curwin) == vim.api.nvim_get_current_win() then
    -- the active statusline shares the width with mode, branch, diff,
    -- diagnostics, encoding, fileformat, filetype, progress and location
    return math.max(15, math.floor(width * 0.4))
  end
  -- the inactive one only keeps location to the right of the name
  return math.max(15, width - 12)
end

local function shorten_filename(text)
  local limit = name_limit()
  if vim.fn.strdisplaywidth(text) <= limit then
    return text
  end

  -- the component appends status symbols ("[+]", "[-]") after the name; keep
  -- them and spend the budget on the name
  local name, symbols = text:match("^(.*)( %[.+%])$")
  name, symbols = name or text, symbols or ""

  local budget = limit - vim.fn.strdisplaywidth(symbols) - 1
  local kept, width = {}, 0
  -- character-wise so multibyte names are not cut mid-character
  for i = 0, vim.fn.strchars(name) - 1 do
    local char = vim.fn.strcharpart(name, i, 1)
    local char_width = vim.fn.strdisplaywidth(char)
    if width + char_width > budget then
      break
    end
    kept[#kept + 1] = char
    width = width + char_width
  end

  return table.concat(kept) .. "…" .. symbols
end

local filename = { "filename", fmt = shorten_filename }

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "solarized_dark" },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { filename },
        lualine_c = { "branch", "diff", "diagnostics", "g:obsidian" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = { filename },
        lualine_c = { "branch", "diff", "diagnostics" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
