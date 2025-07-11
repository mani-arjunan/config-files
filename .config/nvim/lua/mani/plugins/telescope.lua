-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    layout_config = {
      vertical = { width = 0.5 },
      horizontal = { height = 0.9, width = 0.9, preview_cutoff = 0 },
    },
    mappings = {
      i = {
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-s>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")
telescope.load_extension("dir")
telescope.load_extension("git_worktree")
