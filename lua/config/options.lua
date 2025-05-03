local M = {}

function M.setup()
  -- 1. Go syntax highlighting
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

  -- 2. Colorscheme
  vim.cmd.colorscheme('codedark')

  -- 3. Lualine setup
  require('lualine').setup {
    options = { theme = 'onedark' },
  }

  -- 4. Helper: SyntaxInfo
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
