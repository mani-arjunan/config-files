function create_tmux_server () {
  path="$1"
  name="$2"
  windows_needed="${3:-true}"
  is_git_needed="${4:-true}"
  custom_script="$5"
  start_shell="exec zsh"
  EXCLUDED_NAMES="todo playground"

  cd "$path" || { echo "Not a valid path: $path"; return 1; }

  if [ -n "$custom_script" ]; then
    tmux new -s "$name" -n "$name" -d "$custom_script;$start_shell" 
  else
    tmux new -s "$name" -n "$name" -d "nvim .;$start_shell"
  fi

  if [ "$windows_needed" = "true" ] && ! echo "$EXCLUDED_NAMES" | grep -wq "$name"; then
    tmux new-window -t "$name:2" -n "$name-exec" -d
    if [ "$is_git_needed" = "true" ]; then
      tmux new-window -t "$name:3" -n "$name-git" -d "lazygit;$start_shell"
    else
      tmux new-window -t "$name:3" -n "$name-exec-3" -d
    fi
  fi
}

if [ "${1}" != 'import' ]; then
  create_tmux_server "${@}"
fi

