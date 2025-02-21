#!/usr/bin/env bash

CURRENT_SESSION=$(tmux display-message -p '#S')
FIRST_SESSION=$(tmux list-sessions -F "#{session_name}" | head -n 1)
NEXT_SESSION=$(tmux list-sessions -F "#{session_name}" | tail -n 1)

if [[ "$CURRENT_SESSION" = "$FIRST_SESSION" ]]; then
  if [[ -n "$NEXT_SESSION" ]]; then
    tmux switch-client -t "$NEXT_SESSION" \; kill-session -t "$CURRENT_SESSION"
  else
    tmux kill-session -t "$CURRENT_SESSION"
  fi
else
  tmux switch-client -t "$FIRST_SESSION" \; kill-session -t "$CURRENT_SESSION"
fi
