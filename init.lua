-- init.lua
-- lazy.nvim setup
--
vim.cmd([[
source ~/.config/nvim/configs/basic.vim
]])

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

-- Set leader key before lazy setup
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Plugin specification
require("lazy").setup({
  -- Tools
  { "direnv/direnv.vim" },
  { "preservim/nerdtree" },
  { "nvim-lua/plenary.nvim" },
  { 
    "nvim-telescope/telescope.nvim", 
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" }
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" }
  },
  { "tomasky/bookmarks.nvim" },
  { "simeji/winresizer" },
  { "tpope/vim-commentary" },
  { "airblade/vim-gitgutter" },
  { "yegappan/mru" },
  { "neoclide/coc.nvim", branch = "release" },
  { "github/copilot.vim" },
  { "akinsho/toggleterm.nvim", version = "*" },
  { "voldikss/vim-floaterm" },
  { "guns/xterm-color-table.vim" },
  { "chrisbra/Colorizer" },
  { 
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  { 
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" }
  },
  { "neovim/nvim-lspconfig" },
  { "unblevable/quick-scope" },
  { "vim-test/vim-test" },
  { "dhruvasagar/vim-table-mode" },
  { "mbbill/undotree" },

  -- Debugging
  { "mfussenegger/nvim-dap" },
  { 
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }
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
      "nvim-treesitter/nvim-treesitter"
    }
  },
  { 
    "fredrikaverpil/neotest-golang",
    version = "v1.10.2",
    dependencies = { "nvim-neotest/neotest" }
  },

  -- UI
  { 
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  { "nvim-tree/nvim-web-devicons" },

  -- Color scheme
  { "tomasiser/vim-code-dark" },

  -- Git
  { 
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  { 
    "linrongbin16/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  { "f-person/git-blame.nvim" },
  
  -- Go
  { 
    "fatih/vim-go",
    build = ":GoUpdateBinaries"
  },
  { 
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" }
  },
  { "charlespascoe/vim-go-syntax" },
  
  -- SQL
  { "mattn/vim-sqlfmt" },
  { "nanotee/sqls.nvim" },
  { "tpope/vim-dadbod" },
  { 
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" }
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
    end
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
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
  },
})

-- Load Vim script configurations
vim.cmd([[
source ~/.config/nvim/configs/colorscheme.vim
source ~/.config/nvim/configs/keybinds.vim
source ~/.config/nvim/configs/commands.vim
source ~/.config/nvim/configs/filetypes.vim
source ~/.config/nvim/configs/plugins.vim
]])

-- Note: You may want to gradually convert these Vim script files to Lua
-- For example:
-- require('config.basic')
-- require('config.colorscheme')
-- etc.
