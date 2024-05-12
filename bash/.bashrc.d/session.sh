#!/usr/bin/env bash
# vim: shiftwidth=2 tabstop=2 expandtab:

# Modified from: https://wiki.archlinux.org/title/SSH_keys#ssh-agent
#
# Only start one ssh-agent instance, share between terminals.
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
	ssh-agent -t 2d >"$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
  # shellcheck disable=SC1091
	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
