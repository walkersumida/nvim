return {
  {
    "3rd/diagram.nvim",
    dependencies = { "3rd/image.nvim" },
    ft = { "markdown" },
    opts = {
      events = {
        render_buffer = { "TextChanged", "BufWinEnter" },
        clear_buffer = {},
      },
      renderer_options = {
        -- scale: resolution multiplier for the mmdc PNG output; higher = sharper when enlarged.
        mermaid = { theme = "dark", background = "transparent", scale = 4 },
      },
    },
    config = function(_, opts)
      require("diagram").setup(opts)
      -- The mermaid renderer re-runs mmdc on a broken diagram at every render
      -- event and raises an ERROR per stderr chunk, so one syntax error floods
      -- :messages with hit-enter prompts and blocks editing. Wrap the renderer
      -- to remember failed sources and skip them; fixing the source changes its
      -- hash, so it is retried automatically.
      -- The slash path must match how diagram.nvim requires this module
      -- internally; the dot path resolves to a separate cached instance.
      local mermaid = require("diagram/renderers/mermaid")
      local failed_sources = {}
      local orig_render = mermaid.render
      mermaid.render = function(source, options)
        local hash = vim.fn.sha256(source)
        if failed_sources[hash] then return nil end
        local result = orig_render(source, options)
        if result and result.job_id then
          -- mmdc runs async; poll for completion and treat a missing output
          -- PNG as failure. Notify once per broken source, as a short WARN.
          local timer = vim.uv.new_timer()
          if timer then
            timer:start(
              0,
              200,
              vim.schedule_wrap(function()
                if vim.fn.jobwait({ result.job_id }, 0)[1] == -1 then return end
                if timer:is_active() then timer:stop() end
                if timer:is_closing() then return end
                timer:close()
                if vim.fn.filereadable(result.file_path) == 0 then
                  failed_sources[hash] = true
                  vim.notify(
                    "mermaid render failed (likely a syntax error); it will retry once the source is edited",
                    vim.log.levels.WARN,
                    { title = "Diagram.nvim" }
                  )
                end
              end)
            )
          end
        end
        return result
      end
      -- Drop the renderer's own mermaid ERROR notifications (multi-chunk
      -- puppeteer stack traces); the single WARN above is the user-facing
      -- signal. Other Diagram.nvim notifications (e.g. mmdc not installed)
      -- pass through.
      local orig_notify = vim.notify
      vim.notify = function(msg, level, o)
        if
          type(o) == "table"
          and o.title == "Diagram.nvim"
          and type(msg) == "string"
          and msg:find("Failed to render mermaid diagram", 1, true) == 1
        then
          return
        end
        return orig_notify(msg, level, o)
      end
      -- Cached PNGs are keyed by diagram source only, so renderer option changes
      -- (theme, background, ...) don't take effect until the cache is wiped.
      vim.api.nvim_create_user_command("DiagramClearCache", function()
        local dir = require("diagram").get_cache_dir() .. "/mermaid"
        vim.fn.delete(dir, "rf")
        vim.fn.mkdir(dir, "p")
        -- Also forget failed sources so transient failures (not caused by the
        -- diagram source itself) can be retried.
        failed_sources = {}
        require("diagram").render()
        vim.notify("diagram cache cleared: " .. dir)
      end, { desc = "Delete diagram.nvim render cache and re-render" })
      local grp = vim.api.nvim_create_augroup("DiagramInsertGuard", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = grp,
        pattern = "markdown",
        callback = function(a)
          -- Full-size view for diagrams too tall to read inline.
          vim.keymap.set("n", "<leader>dp", function()
            require("diagram").show_diagram_hover()
          end, { buffer = a.buf, desc = "Preview diagram under cursor" })
        end,
      })
      vim.api.nvim_create_autocmd("InsertEnter", {
        group = grp,
        callback = function(a)
          if vim.bo[a.buf].filetype ~= "markdown" then return end
          vim.b[a.buf].diagram_tick = vim.api.nvim_buf_get_changedtick(a.buf)
        end,
      })
      vim.api.nvim_create_autocmd("InsertLeave", {
        group = grp,
        callback = function(a)
          if vim.bo[a.buf].filetype ~= "markdown" then return end
          if vim.api.nvim_buf_get_changedtick(a.buf) ~= vim.b[a.buf].diagram_tick then
            require("diagram").render()
          end
        end,
      })
    end,
  },
}
