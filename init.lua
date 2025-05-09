-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load basic configs before lazy setup
require("config.options").setup()

-- Plugin specification
require("lazy").setup({
  -- Tools
  { "direnv/direnv.vim" },
  { "preservim/nerdtree" },
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  { "tomasky/bookmarks.nvim" },
  { "simeji/winresizer" },
  { "tpope/vim-commentary" },
  { "airblade/vim-gitgutter" },
  { "yegappan/mru" },
  { "github/copilot.vim" },
  { "akinsho/toggleterm.nvim", version = "*" },
  { "voldikss/vim-floaterm" },
  { "guns/xterm-color-table.vim" },
  { "chrisbra/Colorizer" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  { "unblevable/quick-scope" },
  { "vim-test/vim-test" },
  { "dhruvasagar/vim-table-mode" },
  { "mbbill/undotree" },

  -- Load settings from lua/plugins/
  { import = "plugins" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  { "nvim-neotest/nvim-nio" },
  { "m00qek/baleia.nvim" },

  -- Testing
  { "antoinemadec/FixCursorHold.nvim" },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "fredrikaverpil/neotest-golang",
    version = "v1.10.2",
    dependencies = { "nvim-neotest/neotest" },
  },

  -- UI
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "nvim-tree/nvim-web-devicons" },

  -- Color scheme
  { "tomasiser/vim-code-dark" },

  -- Git
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "linrongbin16/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "f-person/git-blame.nvim" },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require("blame").setup({})
    end,
  },

  -- Go
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  { "charlespascoe/vim-go-syntax" },

  -- SQL
  { "mattn/vim-sqlfmt" },
  { "nanotee/sqls.nvim" },
  { "tpope/vim-dadbod" },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
  },

  -- Markdown
  { "preservim/vim-markdown" },

  -- Terraform
  { "hashivim/vim-terraform" },

  -- wilder
  {
    "gelguy/wilder.nvim",
    build = function()
      vim.cmd("UpdateRemotePlugins")
    end,
  },

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
        -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
  },

  {
    "andythigpen/nvim-coverage",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("coverage").setup({
        lang = {
          go = {
            coverage_file = vim.fn.getcwd() .. "/coverage.out",
          },
        },
      })
    end,
  },
})

-- Load configurations
require("config.colorscheme").setup()
require("config.keymaps").setup()
require("config.autocmds").setup()
require("config.buffer").setup()
require("config.commands").setup()
require("config.nerdtree").setup()
require("config.telescope").setup()
require("config.lsp").setup()
require("config.cmp").setup()
require("config.neotest").setup()
require("config.nvim-coverage").setup()
require("config.bookmarks").setup()
require("config.git-blame").setup()
require("config.nvim-dap").setup()
require("config.toggleterm").setup()
require("config.baleia").setup()
require("config.nvim-dap-ui").setup()
require("config.nvim-dap-go").setup()
require("config.lualine").setup()
require("config.nvim-treesitter").setup()
require("config.gitlinker").setup()
require("config.wilder").setup()
require("config.vim-dadbod-ui").setup()
require("config.gitgutter").setup()
require("config.git-messenger").setup()
require("config.quick-scope").setup()
require("config.vim-floaterm").setup()
require("config.vim-markdown").setup()

-- Apply float window and LSP highlight settings
vim.cmd([[
  augroup CustomHighlight
    autocmd!
    autocmd ColorScheme * highlight! FloatBorder guifg=#5E81AC guibg=NONE
    autocmd ColorScheme * highlight! NormalFloat guibg=#2E3440

    " LSP reference highlight
    autocmd ColorScheme * highlight! LspReferenceText guibg=#3B4252
    autocmd ColorScheme * highlight! LspReferenceRead guibg=#3B4252
    autocmd ColorScheme * highlight! LspReferenceWrite guibg=#3B4252
  augroup END

  " Always clear highlight when switching windows (used in conjunction with per-buffer settings)
  augroup GlobalLspHighlightClear
    autocmd!
    autocmd WinEnter,WinLeave,BufEnter * lua vim.lsp.buf.clear_references()
  augroup END

  " Apply immediately
  highlight! FloatBorder guifg=#5E81AC guibg=NONE
  highlight! NormalFloat guibg=#2E3440
  highlight! LspReferenceText guibg=#3B4252
  highlight! LspReferenceRead guibg=#3B4252
  highlight! LspReferenceWrite guibg=#3B4252
]])
