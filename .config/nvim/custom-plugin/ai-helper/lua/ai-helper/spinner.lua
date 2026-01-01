local spinner = {}

local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

function spinner.start(message)
  local bufnr = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(bufnr, false, {
    relative = "editor",
    width = 25,
    height = 1,
    row = vim.o.lines - 2,
    col = math.floor((vim.o.columns - 25) / 2),
    style = "minimal",
    border = "rounded",
    noautocmd = true,
  })

  local i = 1
  local running = true
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { frames[i] .. " " .. message })

  local timer = vim.loop.new_timer()
  timer:start(0, 100, vim.schedule_wrap(function()
    if not running then return end
    i = (i % #frames) + 1
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { frames[i] .. " " .. message })
    end
  end))

  return {
    stop = function()
      running = false
      timer:stop()
      timer:close()
      if vim.api.nvim_win_is_valid(win) then vim.api.nvim_win_close(win, true) end
    end,
  }
end

return spinner
