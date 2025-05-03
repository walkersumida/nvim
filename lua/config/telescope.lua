local M = {}

function M.setup()
  local lga_actions = require("telescope-live-grep-args.actions")
  local fb_actions = require("telescope").extensions.file_browser.actions
  require('telescope').setup {
    defaults = {
      mappings = {
        i = {
          ['<C-j>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
          ["<C-f>"] = false,
        }
      },
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '-u'
      },
      file_ignore_patterns = {
        "node_modules/",
        ".git/",
        ".DS_Store",
        ".yarn"
      }
    },
    pickers = {
      buffers = {
        sort_lastused = true,
        sort_mru = true
      },
      find_files = {
        hidden = true
      }
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-i>"] = lga_actions.quote_prompt(),
          }
        }
      },
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
        no_ignore = true,
        hidden = { file_browser = true, folder_browser = true },
        mappings = {
          ["i"] = {
            ["<C-h>"] = false
          },
          ["n"] = {
            g = false,
            u = fb_actions.goto_parent_dir
          },
        },
      },
    }
  }
  require("telescope").load_extension("live_grep_args")
  require('telescope').load_extension('bookmarks')
  require("telescope").load_extension("file_browser")
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope git_status<cr>')
  vim.keymap.set('n', '<leader>ft', '<cmd>Telescope treesitter<cr>')
  vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<cr>')
  vim.keymap.set('n', '<leader>fh', '<cmd>Telescope oldfiles theme=ivy<cr>')
  vim.keymap.set('n', '<leader>fm', '<cmd>Telescope bookmarks list<cr>')
  vim.keymap.set('n', '<leader>k', '<cmd>Telescope commands<cr>')
  vim.keymap.set('n', '<leader>gg', function()
    require('telescope').extensions.live_grep_args.live_grep_args()
  end)
  vim.keymap.set('n', '<leader>gc', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
  vim.keymap.set('n', '<C-b>', '<cmd>Telescope buffers<cr>')
end

return M
