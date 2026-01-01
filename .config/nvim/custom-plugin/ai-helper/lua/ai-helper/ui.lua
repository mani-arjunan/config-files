local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local ui = {}

local function make_previewer(output, filetype)
  return previewers.new_buffer_previewer({
    title = "Generated Code Preview",
    define_preview = function(self)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(output or "", "\n"))
      vim.bo[self.state.bufnr].filetype = filetype or "text"
    end,
    scroll_fn = function(self, direction)
      local win = self.state.winid
      if win and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_call(win, function()
          if direction > 0 then
            vim.cmd("normal! ")
          else
            vim.cmd("normal! ")
          end
        end)
      end
    end,
  })
end

-- Main function to show AI result
function ui.show_output(ctx, output)
  pickers.new({}, {
    prompt_title = "AI Helper Result",
    finder = finders.new_table({
      results = {
        { value = "confirm", display = "✅ Confirm" },
        { value = "regen", display = "🔄 Regenerate" },
      },
      entry_maker = function(entry)
        return {
          value = entry.value,
          display = entry.display,
          ordinal = entry.display,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = make_previewer(output, ctx.filetype),

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,        -- 95% of the editor width
      height = 0.85,       -- 85% of the editor height
      preview_width = 0.75 -- make preview take 75% of total width
    },

    attach_mappings = function(prompt_bufnr, map)
      local function on_select()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection.value == "confirm" then
          vim.schedule(function()
            local bufnr = vim.api.nvim_get_current_buf()
            local new_lines = vim.split(output or "", "\n", { plain = true })
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
            vim.notify("✅ AI content applied", vim.log.levels.INFO)
          end)
        elseif selection.value == "regen" then
          vim.schedule(function()
            require("ai-helper.regen").regenerate(ctx, output)
          end)
        end
      end

      map("i", "<CR>", on_select)
      map("n", "<CR>", on_select)

      map("n", "/", function()
        local preview_buf = action_state.get_current_picker(prompt_bufnr).previewer.state.bufnr
        if preview_buf and vim.api.nvim_buf_is_valid(preview_buf) then
          vim.cmd("new")
          local new_win = vim.api.nvim_get_current_win()
          vim.api.nvim_win_set_buf(new_win, preview_buf)
          vim.bo[preview_buf].modifiable = false
          vim.bo[preview_buf].readonly = true
          vim.notify("Opened preview in a new window (read-only search mode)")
        end
      end)

      map("i", "<C-j>", actions.preview_scrolling_down)
      map("i", "<C-k>", actions.preview_scrolling_up)
      map("n", "<C-j>", actions.preview_scrolling_down)
      map("n", "<C-k>", actions.preview_scrolling_up)

      return true
    end,
  }):find()
end

return ui
