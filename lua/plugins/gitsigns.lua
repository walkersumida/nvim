return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end)

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end)

          map("n", "<leader>hQ", function()
            gitsigns.setqflist("all")
          end)

          map("n", "<leader>hp", gitsigns.preview_hunk)
          map("n", "<leader>hi", gitsigns.preview_hunk_inline)
          map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
          end)

          map("n", "<leader>hd", gitsigns.diffthis)
          map("n", "<leader>hD", function()
            gitsigns.diffthis("~")
          end)

          -- Telescope integration - current buffer
          map("n", "<leader>fd", function()
            -- Try different approaches
            local ok = pcall(function()
              gitsigns.setqflist(0, { open = false })
            end)
            if not ok then
              -- Fallback to simple call
              gitsigns.setqflist()
            end

            vim.defer_fn(function()
              local qflist = vim.fn.getqflist()
              if #qflist == 0 then
                vim.notify("No git hunks found in current buffer", vim.log.levels.INFO)
              else
                local pickers = require("telescope.pickers")
                local finders = require("telescope.finders")
                local conf = require("telescope.config").values
                local previewers = require("telescope.previewers")
                local make_entry = require("telescope.make_entry")

                -- Get hunks for current buffer to match with quickfix entries
                local hunks = gitsigns.get_hunks(bufnr)
                local hunk_map = {}
                if hunks then
                  for _, hunk in ipairs(hunks) do
                    hunk_map[hunk.added.start] = hunk
                  end
                end

                -- Create custom picker for quickfix with enhanced preview
                pickers
                  .new({}, {
                    prompt_title = "Git Hunks",
                    finder = finders.new_table({
                      results = qflist,
                      entry_maker = make_entry.gen_from_quickfix({}),
                    }),
                    sorter = conf.generic_sorter({}),
                    previewer = previewers.new_buffer_previewer({
                      define_preview = function(self, entry, status)
                        local preview_bufnr = self.state.bufnr
                        local filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr)
                        local lnum = entry.lnum

                        -- Load file content
                        local lines = vim.fn.readfile(filename)
                        vim.api.nvim_buf_set_lines(preview_bufnr, 0, -1, false, lines)

                        -- Set filetype for syntax highlighting
                        local ft = vim.filetype.match({ filename = filename })
                        if ft then
                          vim.api.nvim_buf_set_option(preview_bufnr, "filetype", ft)
                        end

                        -- Find corresponding hunk and highlight range
                        local hunk = hunk_map[lnum]
                        if hunk then
                          local start_line = hunk.added.start
                          local end_line = start_line + hunk.added.count - 1

                          local hl_group = "DiffAdd"
                          if hunk.type == "change" then
                            hl_group = "DiffChange"
                          elseif hunk.type == "delete" then
                            hl_group = "DiffDelete"
                          end

                          -- Highlight all lines in the hunk
                          for line = start_line, end_line do
                            vim.api.nvim_buf_add_highlight(preview_bufnr, -1, hl_group, line - 1, 0, -1)
                          end
                        else
                          -- Fallback: highlight just the single line
                          vim.api.nvim_buf_add_highlight(preview_bufnr, -1, "DiffAdd", lnum - 1, 0, -1)
                        end

                        -- Set cursor position safely
                        vim.schedule(function()
                          local line_count = vim.api.nvim_buf_line_count(preview_bufnr)
                          local target_line = math.min(lnum, line_count)
                          target_line = math.max(1, target_line)

                          pcall(vim.api.nvim_win_set_cursor, self.state.winid, { target_line, 0 })
                        end)
                      end,
                    }),
                  })
                  :find()
              end
            end, 100)
          end, { desc = "Git hunks in Telescope (current buffer)" })

          -- Telescope integration - all files with dynamic base
          map("n", "<leader>fD", function()
            local pickers = require("telescope.pickers")
            local finders = require("telescope.finders")
            local conf = require("telescope.config").values
            local previewers = require("telescope.previewers")

            -- Check if ref is a commit hash (not a branch name)
            local function is_commit_hash(ref)
              -- Check if it exists as a branch
              vim.fn.system({ "git", "show-ref", "--verify", "--quiet", "refs/heads/" .. ref })
              if vim.v.shell_error == 0 then
                return false -- It's a branch name
              end
              -- Check if it's a valid commit
              vim.fn.system({ "git", "rev-parse", "--verify", "--quiet", ref .. "^{commit}" })
              return vim.v.shell_error == 0
            end

            -- Get the current base branch or ask user for input
            local base_branch = vim.fn.input("Base branch (default: develop): ", "develop")
            if base_branch == "" then
              base_branch = "develop"
            end

            -- Determine diff range based on whether input is commit hash or branch
            local diff_range
            if is_commit_hash(base_branch) then
              diff_range = base_branch .. "^..HEAD" -- Include the specified commit
              require("gitsigns").change_base(base_branch .. "^", true)
            else
              diff_range = base_branch .. "...HEAD" -- merge-base for branches
              require("gitsigns").change_base(base_branch, true)
            end

            -- Get all changed files with their hunks
            local cmd = vim.fn.systemlist({
              "git",
              "diff",
              "--name-only",
              diff_range,
            })

            local changed_files = {}
            for _, file in ipairs(cmd) do
              if file ~= "" then
                table.insert(changed_files, file)
              end
            end

            if #changed_files == 0 then
              vim.notify("No changes found vs " .. base_branch, vim.log.levels.INFO)
              return
            end

            -- Create entries with hunk information
            local entries = {}
            for _, file in ipairs(changed_files) do
              -- Get hunks for each file using git diff
              local diff_output = vim.fn.systemlist({
                "git",
                "diff",
                "--unified=0",
                diff_range,
                "--",
                file,
              })

              local hunks = {}
              local current_hunk = nil
              for _, line in ipairs(diff_output) do
                if line:match("^@@") then
                  -- Parse hunk header like @@ -10,5 +10,7 @@
                  local old_start, old_count, new_start, new_count = line:match("^@@ %-(%d+),?(%d*) %+(%d+),?(%d*) @@")
                  if new_start then
                    current_hunk = {
                      start = tonumber(new_start),
                      count = tonumber(new_count) or 1,
                      type = "change",
                    }
                    table.insert(hunks, current_hunk)
                  end
                end
              end

              -- Add one entry per file with all its hunks
              table.insert(entries, {
                filename = file,
                lnum = hunks[1] and hunks[1].start or 1,
                text = #hunks > 0 and string.format("%d hunk%s", #hunks, #hunks > 1 and "s" or "") or "File changed",
                hunks = hunks, -- Store all hunks for preview
              })
            end

            -- Create custom picker with enhanced preview
            pickers
              .new({}, {
                prompt_title = "Git hunks (all files vs " .. base_branch .. ")",
                finder = finders.new_table({
                  results = entries,
                  entry_maker = function(entry)
                    return {
                      value = entry,
                      display = string.format("%s  %s", entry.filename, entry.text),
                      ordinal = entry.filename,
                      filename = entry.filename,
                      lnum = entry.lnum,
                      hunks = entry.hunks,
                    }
                  end,
                }),
                sorter = conf.generic_sorter({}),
                previewer = previewers.new_buffer_previewer({
                  define_preview = function(self, entry, status)
                    local preview_bufnr = self.state.bufnr
                    local filename = entry.filename
                    local lnum = entry.lnum

                    -- Load file content from current state
                    local file_exists = vim.fn.filereadable(filename) == 1
                    local lines = {}

                    if file_exists then
                      lines = vim.fn.readfile(filename)
                    else
                      -- New file, get content from git
                      lines = vim.fn.systemlist({ "git", "show", "HEAD:" .. filename })
                      if vim.v.shell_error ~= 0 then
                        lines = { "New file (content not available)" }
                      end
                    end

                    vim.api.nvim_buf_set_lines(preview_bufnr, 0, -1, false, lines)

                    -- Set filetype for syntax highlighting
                    local ft = vim.filetype.match({ filename = filename })
                    if ft then
                      vim.api.nvim_buf_set_option(preview_bufnr, "filetype", ft)
                    end

                    -- Highlight all hunks if available
                    if entry.hunks and #entry.hunks > 0 then
                      -- Get diff to determine change types
                      local diff_output = vim.fn.systemlist({
                        "git",
                        "diff",
                        diff_range,
                        "--",
                        filename,
                      })

                      -- Process each hunk
                      for _, hunk in ipairs(entry.hunks) do
                        local start_line = hunk.start
                        local end_line = start_line + hunk.count - 1

                        local in_hunk = false
                        local hl_group = "DiffChange"

                        for _, line in ipairs(diff_output) do
                          if line:match("^@@.*%+" .. start_line .. "[,%s]") then
                            in_hunk = true
                          elseif line:match("^@@") then
                            in_hunk = false
                          elseif in_hunk then
                            if line:match("^%+") and not line:match("^%+%+%+") then
                              hl_group = "DiffAdd"
                            elseif line:match("^%-") and not line:match("^%-%-%-") then
                              hl_group = "DiffDelete"
                            end
                          end
                        end

                        -- Highlight all lines in the hunk
                        for line = start_line, end_line do
                          if line <= #lines then
                            vim.api.nvim_buf_add_highlight(preview_bufnr, -1, hl_group, line - 1, 0, -1)
                          end
                        end
                      end
                    else
                      -- Fallback: highlight just the single line
                      if lnum <= #lines then
                        vim.api.nvim_buf_add_highlight(preview_bufnr, -1, "DiffAdd", lnum - 1, 0, -1)
                      end
                    end

                    -- Set cursor position safely
                    vim.schedule(function()
                      local line_count = vim.api.nvim_buf_line_count(preview_bufnr)
                      local target_line = math.min(lnum, line_count)
                      target_line = math.max(1, target_line)

                      pcall(vim.api.nvim_win_set_cursor, self.state.winid, { target_line, 0 })
                    end)
                  end,
                }),
                attach_mappings = function(prompt_bufnr, map)
                  local actions = require("telescope.actions")
                  local action_state = require("telescope.actions.state")

                  map("i", "<CR>", function()
                    local selection = action_state.get_selected_entry()
                    actions.close(prompt_bufnr)
                    vim.cmd("edit " .. selection.filename)
                    if selection.lnum then
                      vim.api.nvim_win_set_cursor(0, { selection.lnum, 0 })
                    end
                  end)

                  return true
                end,
              })
              :find()
          end, { desc = "Git hunks in Telescope (all files with base)" })
        end,
      })
    end,
  },
}
