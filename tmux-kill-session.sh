#!/usr/bin/env bash

if [[ $(tmux list-sessions | wc -l) -gt 1 ]]; then
  tmux switch-client -l && tmux kill-session
else
  tmux kill-server
fi

