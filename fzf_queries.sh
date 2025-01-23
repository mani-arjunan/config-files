#!/bin/bash

while true; do
    FILE=$(find ~/queries -mindepth 1 -maxdepth 1 -type d | awk -F/ '{print $NF}' | fzf)

    if [[ -n "$FILE" ]]; then
      tmux new-window "cd "~/queries/$FILE" && ./index.sh"
    fi
done
