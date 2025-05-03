local M = {}

function M.setup()
  local wilder = require('wilder')

  wilder.setup({
    modes = { ':', '/', '?' }
  })

  wilder.set_option('renderer', wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      highlighter = wilder.basic_highlighter(),
      highlights = {
        border = 'Normal',
      },
      border = 'rounded',
      pumblend = 20,
    })
  ))
end

return M
