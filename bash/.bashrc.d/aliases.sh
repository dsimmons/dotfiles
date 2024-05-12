#!/usr/bin/env bash
# vim: shiftwidth=2 tabstop=2 expandtab:

# I used to have a 'gs' alias for `git status`. Turns out, that's an actual
# binary, and I've accidentally started it about 1000 times. This effectively
# just prevents me from being able to do that!
alias gs='echo DERP!'

alias g='git'
alias ll='lsd -la'
alias kc='kubectl'
alias dc='docker-compose'
alias lzd='lazydocker'
alias lzg='lazygit'

# Open Neovim with PWD set to $NOTES_DIR as fuzzy finding root.
alias notes='nvim +lcd $NOTES_DIR'

# Open Neovim with PWD set to ~/dotfiles as fuzzy finding root.
#
# Technically there's a Unix `dot` bin, but I'm fine clobbering it until there's
# a reason to need it. `dot` is much easier to type vs something like `dotf`.
alias dot='nvim +lcd $HOME/dotfiles'
alias blog='cd $HOME/projects/blog && nvim'
