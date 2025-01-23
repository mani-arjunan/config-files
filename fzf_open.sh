#!/bin/bash

while true; do
    FILE=$(find ~/Documents | fzf)

    if [[ -n "$FILE" ]]; then
      tmux new-window "cd $(dirname "$FILE") && nvim $FILE"
    fi
done
