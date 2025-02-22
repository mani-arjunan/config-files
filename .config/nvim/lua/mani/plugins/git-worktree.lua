local setup, gw = pcall(require, "git-worktree")
if not setup then
  return
end

gw.setup()
