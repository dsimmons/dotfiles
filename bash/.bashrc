#!/usr/bin/env bash
# vim: shiftwidth=2 tabstop=2 expandtab:

# Source global definitions.
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Add user-specific bins to $PATH.
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Load user-specific shell configuration.
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc
