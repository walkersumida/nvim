-- Detailed LSP settings

local M = {}

function M.setup()
  -- Basic LSP settings
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  capabilities.offsetEncoding = { "utf-8" }

  -- Position encoding settings (version-independent method)
  local orig_util_apply_text_edits = vim.lsp.util.apply_text_edits
  vim.lsp.util.apply_text_edits = function(edits, bufnr, offset_encoding)
    offset_encoding = offset_encoding or "utf-8"
    return orig_util_apply_text_edits(edits, bufnr, offset_encoding)
  end

  -- Definition of highlight colors (global)
  vim.cmd([[
    highlight! LspReferenceText guibg=#3B4252
    highlight! LspReferenceRead guibg=#3B4252
    highlight! LspReferenceWrite guibg=#3B4252
  ]])

  -- Global document highlight settings
  local global_lsp_highlight_grp = vim.api.nvim_create_augroup("GlobalLspDocumentHighlight", { clear = true })

  -- CursorHold and CursorMoved processing applied to all buffers
  vim.api.nvim_create_autocmd("CursorHold", {
    group = global_lsp_highlight_grp,
    pattern = "*",
    callback = function()
      -- Check active LSP servers for the current buffer
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      -- Execute only if a server exists and supports documentHighlightProvider
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          vim.lsp.buf.document_highlight()
          return
        end
      end
    end,
  })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = global_lsp_highlight_grp,
    pattern = "*",
    callback = function()
      -- Check active LSP servers for the current buffer
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      -- Execute clear processing only if a server exists
      if #clients > 0 then
        vim.lsp.buf.clear_references()
      end
    end,
  })

  -- Clear highlights when buffer or window changes (global)
  vim.api.nvim_create_autocmd({ "BufLeave", "WinLeave", "WinEnter" }, {
    group = global_lsp_highlight_grp,
    pattern = "*",
    callback = function()
      -- Check active LSP servers for the current buffer
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      -- Execute clear processing only if a server exists
      if #clients > 0 then
        vim.lsp.buf.clear_references()
      end
    end,
  })

  -- Key mapping function
  local on_attach = function(client, bufnr)
    -- Diagnostics and navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
    vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
    -- Use Telescope with preview feature when searching for references
    vim.keymap.set("n", "gr", function()
      require("telescope.builtin").lsp_references({
        include_declaration = true,
        show_line = false,
      })
    end, { buffer = bufnr, desc = "Go to references (with preview)" })
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
      })
    end, { buffer = bufnr, desc = "Show hover documentation" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
    vim.keymap.set("n", "[g", function()
      vim.diagnostic.goto_prev({
        float = {
          border = "rounded",
        },
      })
    end, { buffer = bufnr, desc = "Previous diagnostic" })
    vim.keymap.set("n", "]g", function()
      vim.diagnostic.goto_next({
        float = {
          border = "rounded",
        },
      })
    end, { buffer = bufnr, desc = "Next diagnostic" })
  end

  local function jump_definition_with_keypress()
    print("Press v for vsplit, h for split, t for tabedit (default: current window)")

    local ok, key = pcall(vim.fn.getchar)
    if not ok then
      print("Cancelled")
      return
    end

    -- Convert to string (getchar returns a number if it's a single-byte char)
    key = type(key) == "number" and vim.fn.nr2char(key) or key

    if key == "v" then
      vim.cmd("vsplit")
    elseif key == "h" then
      vim.cmd("split")
    elseif key == "t" then
      vim.cmd("tabedit")
    else
      print("Opening in current window")
    end

    vim.lsp.buf.definition()
  end

  -- Custom jump setting for <C-]>
  vim.keymap.set("n", "<C-]>", jump_definition_with_keypress, { noremap = true, desc = "Definition with split choice" })

  -- Server settings
  -- TypeScript
  lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- ESLint
  lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      autoFixOnSave = true,
    },
  })

  -- JSON
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  -- YAML
  lspconfig.yamlls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      yaml = {
        schemaStore = {
          enable = true,
          url = "",
        },
      },
    },
  })

  -- Go (gopls)
  lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
        gofumpt = true,
        usePlaceholders = true,
        completeUnimported = true,
      },
    },
    flags = {
      debounce_text_changes = 150,
    },
  })

  -- SQL (sqls)
  lspconfig.sqls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
    end,
    cmd = { "sqls", "-config", vim.fn.expand("$HOME/.config/sqls/config.yml") },
    filetypes = { "sql" },
  })

  -- Terraform (terraform-ls)
  lspconfig.terraformls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "terraform", "tf", "tfvars" },
  })

  -- Lua (lua-language-server)
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })

  require("conform").setup({
    formatters_by_ft = {
      go = { "goimports", "gofmt" },
      javascript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
      lua = { "stylua" },
      python = { "isort", "black" },
      rust = { "rustfmt", lsp_format = "fallback" },
      sql = { "sql_formatter" },
      typescript = { "prettierd", "prettier", "eslint_d", stop_after_first = true },
    },
    formatters = {
      stylua = {
        command = "stylua",
        args = {
          "--indent-type",
          "Spaces",
          "--indent-width",
          "2",
          "--search-parent-directories",
          "--stdin-filepath",
          "$FILENAME",
          "-",
        },
        stdin = true,
      },
    },
    format_on_save = {
      timeout_ms = 5000,
      lsp_format = "fallback",
    },
  })

  -- Auto format on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*" },
    callback = function(args)
      require("conform").format({ bufnr = args.buf })
    end,
  })

  -- Disable completion for Markdown and JSON (migrated from coc.nvim settings)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "json" },
    callback = function()
      -- Disable completion for specific file types in nvim-cmp
      require("cmp").setup.buffer({ enabled = false })
    end,
  })
end

return M
