#!/usr/bin/env bash

FILE=$(find ~/Documents/max ~/personal -mindepth 1 -maxdepth 1 -type d | fzf)

if [[ -n "$FILE" ]]; then
  SESSION_NAME=$(basename "$FILE" | tr . _)

  if ! tmux has-session -t "$SESSION_NAME" 2> /dev/null; then
    ~/create-tmux.sh "$FILE" "$SESSION_NAME" true false
  fi

  tmux switch-client -t "$SESSION_NAME"
fi
