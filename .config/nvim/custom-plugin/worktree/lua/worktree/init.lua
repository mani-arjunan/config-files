local M = {}

pcall(require, "telescope")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local themes = require('telescope.themes')
local action_state = require("telescope.actions.state")

local function repo_root()
  local dir = vim.loop.cwd()
  -- not sure looping untill the root be the right one, i will optimize it later.
  while dir ~= "/" do
    if
        vim.fn.isdirectory(dir .. "/.git") == 1 or
        vim.fn.isdirectory(dir .. "/worktrees") or
        (vim.fn.isdirectory(dir .. "/refs") == 1 and vim.fn.isdirectory(dir .. "/info") == 1)
    then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

local function list_remote_branches(root)
  local res = vim.system({ "git", "branch", "-a" }, { text = true, cwd = root }):wait()
  local out = vim.split(res.stdout or "", "\n", { trimempty = true })
  local items = {}
  for _, l in ipairs(out) do
    table.insert(items, l)
  end
  return items
end

local function parse_worktree_line(line)
  -- am poor at regex, so used gpt.
  local path = line:match("^([^%s]+)")
  local branch = line:match("%[(.-)%]")
  return { path = path, branch = branch }
end

local function list_worktrees(root)
  local res = vim.system({ "git", "worktree", "list" }, { text = true, cwd = root }):wait()
  local out = vim.split(res.stdout or "", "\n", { trimempty = true })

  local items = {}
  for _, l in ipairs(out) do
    if l and vim.trim(l) ~= "" then
      local wt = parse_worktree_line(l)
      if wt.path then
        table.insert(items, wt)
      end
    end
  end
  return items
end

local function switch_to(worktree)
  if not worktree or not worktree.path then
    return
  end

  -- not needed at all, i have OCD, i need to clear the existing buffers.
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end

  vim.cmd("cd " .. worktree.path)

  local ok, api = pcall(require, "nvim-tree.api")
  if ok then
    api.tree.close()
    api.tree.open({ path = worktree.path, focus = false })

    -- won't work in anyother system other than mani, custom configured to
    -- have same directory across my horizontal tmux windows
    -- FYI i had this hook at primeagen plugin as well
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
              local cmd =
                  string.format("tmux send-keys -t %s:%s 'cd %s && clear' C-m", session_name, win, worktree.path)
              os.execute(cmd)
            end
          end
          win_handle:close()
        end
      end
    end
  else
    vim.notify("nvim-tree is required")
  end
end

local function fetch_remote_branch(root, branch)
  branch = branch:gsub("^%s*[%*%+]?%s*", ""):gsub("^origin/", ""):gsub("%s*$", "")

  local path = root .. "/" .. branch

  vim.cmd("!git worktree add " .. path)
  switch_to({ path = path, branch = branch })
end

local function create_worktree(root)
  root = root or repo_root()
  if not root then
    vim.notify("Not inside a git repo")
    return
  end

  local branch_details = { base_branch = nil, new_branch = nil, path = nil }

  vim.ui.input({ prompt = "Base branch to create ur new branch: " }, function(base)
    if not base or base == "" then
      return
    end
    branch_details.base_branch = vim.trim(base)

    vim.ui.input({ prompt = "Enter new branch name: " }, function(newb)
      if not newb or newb == "" then
        return
      end
      branch_details.new_branch = vim.trim(newb)

      local default_path = root .. "/" .. branch_details.new_branch
      -- often times i faced this issue on primeagen plugin
      -- where one branch would checked out under another branch instead of root
      -- so am just double confirming my path here
      vim.ui.input({ prompt = "confirm the path: ", default = default_path }, function(p)
        if not p or p == "" then
          return
        end
        branch_details.path = vim.fn.fnamemodify(p, ":p")

        local args = { "git", "worktree", "add", "-b", branch_details.new_branch, branch_details.path, branch_details
            .base_branch }
        local res = vim.system(args, { text = true, cwd = root }):wait()
        local out = vim.split(res.stdout or "", "\n", { trimempty = true })

        if code ~= 0 then
          vim.notify("Failed to add worktree")
          return
        end

        switch_to({ path = branch_details.path, branch = branch_details.new_branch })
      end)
    end)
  end)
end

local function delete_worktree(worktree, root)
  local is_current_path = worktree.path == vim.loop.cwd()
  if not worktree or not worktree.path then
    return
  end

  local branch = worktree.branch

  vim.cmd("!git worktree remove " .. worktree.path)
  vim.cmd("!rm -rf " .. root .. "/refs/heads " .. branch)

  if is_current_path then
    switch_to(root .. "/main")
  end
end

local function open_picker(mode)
  local root = repo_root()
  if not root then
    vim.notify("Not inside a git repo")
    return
  end

  local items
  if mode == "fetch" then
    items = list_remote_branches(root)
  else
    items = list_worktrees(root)
    if mode == "switch" then
      table.insert(items, 1, { path = root, branch = "Create new worktree…", _create = true })
    end
  end

  pickers
      .new(themes.get_dropdown({
        prompt_title = 'Git Worktrees',
        previewer = false,
      }), {
        finder = finders.new_table({
          results = items,
          entry_maker = function(item)
            return {
              value = item,
              display = item.branch or item.path or item,
              ordinal = item.branch or item.path or item,
            }
          end,
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr)
          local function on_select()
            local selection = action_state.get_selected_entry()
            actions.close(prompt_bufnr)
            if not selection or not selection.value then
              return
            end
            local value = selection.value  

            if mode == "delete" then
              delete_worktree(value, root)
            elseif mode == "create" then
              create_worktree(root)
            elseif mode == "fetch" then
              fetch_remote_branch(root, value)
            else
              if value._create then
                create_worktree(root)
              else
                switch_to(value)
              end
            end
          end

          actions.select_default:replace(on_select)
          return true
        end,
      })
      :find()
end

function M.open()
  open_picker("switch")
end

function M.delete()
  open_picker("delete")
end

function M.fetch()
  open_picker("fetch")
end

function M.setup()
  vim.api.nvim_create_user_command("Worktrees", M.open)
  vim.api.nvim_create_user_command("WorktreesDelete", M.delete)
  vim.api.nvim_create_user_command("WorktreesFetch", M.fetch)
end

return M
