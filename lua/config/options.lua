local M = {}

function M.setup()
  -- General
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "
  vim.o.updatetime = 300
  vim.opt.encoding = 'utf-8'
  vim.opt.history = 500
  vim.opt.autoread = true
  vim.opt.ignorecase = true
  vim.opt.smartcase = true
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- Undo
  vim.opt.undodir = vim.fn.expand('~/.config/nvim/tmp/undodir')
  vim.opt.undofile = true

  -- Language
  vim.cmd('language en_US.UTF-8')

  -- Cursor
  vim.opt.cursorline = true
  vim.opt.cursorcolumn = true
  vim.api.nvim_set_hl(0, 'CursorLine', { bold = true })
  vim.api.nvim_set_hl(0, 'CursorColumn', { bold = true })
  vim.opt.whichwrap:append('<,>,h,l')

  -- Clipboard
  vim.opt.clipboard:append('unnamed')

  -- Indentation
  vim.opt.expandtab = true
  vim.opt.smarttab = true
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.linebreak = true
  vim.opt.textwidth = 500
  vim.opt.autoindent = true
  vim.opt.smartindent = true
  vim.opt.wrap = true

  vim.o.winborder = 'none'

  -- Go syntax highlighting
  vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = function()
      vim.cmd('highlight goFuncDecl ctermfg=4 guifg=#379DE2')
      vim.cmd('highlight goNonPrimitiveType ctermfg=2 guifg=#40B200')
      vim.cmd('highlight goPackageName ctermfg=2 guifg=#40B200')
      vim.cmd('highlight goFuncBlock ctermfg=117 guifg=#9cdcfe')
      vim.cmd('highlight goFuncCallArgs ctermfg=117 guifg=#9cdcfe')
      vim.cmd('highlight goField ctermfg=117 guifg=#9cdcfe')
      vim.cmd('highlight goImportedPackages ctermfg=117 guifg=#9cdcfe')
      vim.cmd('highlight goSliceOrArrayType ctermfg=176 guifg=#c586c0')
      vim.cmd('highlight goBraces ctermfg=176 guifg=#c586c0')
      vim.cmd('highlight goStructLiteralBlock ctermfg=117 guifg=#9cdcfe')
      vim.cmd('highlight goStructLiteralField ctermfg=117 guifg=#9cdcfe')
      vim.cmd('highlight goFuncCallParens ctermfg=176 guifg=#c586c0')
    end
  })

  -- Helper: SyntaxInfo
  local function get_syn_id(transparent)
    local synid = vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 1)
    if transparent then
      return vim.fn.synIDtrans(synid)
    else
      return synid
    end
  end

  local function get_syn_attr(synid)
    return {
      name = vim.fn.synIDattr(synid, 'name'),
      ctermfg = vim.fn.synIDattr(synid, 'fg', 'cterm'),
      ctermbg = vim.fn.synIDattr(synid, 'bg', 'cterm'),
      guifg = vim.fn.synIDattr(synid, 'fg', 'gui'),
      guibg = vim.fn.synIDattr(synid, 'bg', 'gui'),
    }
  end

  local function get_syn_info()
    local base_syn = get_syn_attr(get_syn_id(false))
    print(string.format(
      'name: %s ctermfg: %s ctermbg: %s guifg: %s guibg: %s',
      base_syn.name, base_syn.ctermfg, base_syn.ctermbg, base_syn.guifg, base_syn.guibg
    ))
    local linked_syn = get_syn_attr(get_syn_id(true))
    print('link to')
    print(string.format(
      'name: %s ctermfg: %s ctermbg: %s guifg: %s guibg: %s',
      linked_syn.name, linked_syn.ctermfg, linked_syn.ctermbg, linked_syn.guifg, linked_syn.guibg
    ))
  end

  vim.api.nvim_create_user_command('SyntaxInfo', get_syn_info, {})
end

return M
