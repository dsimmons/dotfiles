#!/usr/bin/env bash
# vim: shiftwidth=2 tabstop=2 expandtab:

export NOTES_DIR="$HOME/notes"
export JOURNAL_DIR="$NOTES_DIR/journal"

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.foundry/bin"

# Node.js
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

# Starship prompt
if command -v starship &> /dev/null; then
  eval "$(starship init bash)"
fi
