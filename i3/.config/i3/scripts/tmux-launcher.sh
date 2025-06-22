#!/bin/bash

if tmux has-session 2>/dev/null; then
  tmux attach || tmux new
else
  tmux
fi
