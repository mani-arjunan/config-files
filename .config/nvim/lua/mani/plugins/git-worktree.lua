local setup, gw = pcall(require, "git-worktree")
if not setup then
  return
end

gw.setup()

gw.on_tree_change(function(op, metadata)
  if op == gw.Operations.Switch then
    local handle = io.popen("tmux display-message -p '#S'")
    if handle then
      local session_name = handle:read("*a"):gsub("%s+", "")
      handle:close()

      local current_window_handle = io.popen("tmux display-message -p '#I'")
      if current_window_handle then
        local current_window = current_window_handle:read("*a"):gsub("%s+", "")
        current_window_handle:close()

        local win_handle = io.popen("tmux list-windows -t " .. session_name .. " -F '#I'")
        if win_handle then
          for win in win_handle:lines() do
            if win ~= current_window then
              local cmd = string.format("tmux send-keys -t %s:%s 'cd %s' C-m", session_name, win, metadata.path)
              os.execute(cmd)
            end
          end
          win_handle:close()
        end
      end
    end
  end
end)
