#!/usr/bin/env bash

FILE=$(find ~/Documents/work ~/personal -maxdepth 1 -type d | fzf)
CURRENT_TERM=$(echo $TERM)

if [[ -n "$FILE" ]]; then
  SESSION_NAME="$(basename "$FILE" | tr . _)-git"

  if ! tmux has-session -t "$SESSION_NAME" 2> /dev/null; then
    git branch --show-current
  fi

  if [[ $CURRENT_TERM = "tmux-256color" ]]; then
    tmux switch-client -t "$SESSION_NAME"
  else
    tmux attach
  fi
fi
