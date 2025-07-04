#!/bin/bash

last=""
(while true; do
  current=$(pbpaste)
  if [ "$current" != "$last" ] && [ -n "$current" ]; then
    echo $current >> ~/clipboard-script/clipboard_history.txt
    last="$current"
  fi
  sleep 1
done) &
