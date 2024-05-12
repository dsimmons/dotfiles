#!/usr/bin/env bash

# [G]et [T]hings [D]one
#
# A little mini-hub of nvim splits that manage my daily life. This function
# saves me the effort of doing all of this manually, each/every time.
gtd() {
  TODAY="$(date --rfc-3339=date).md"
  YESTERDAY="$(date --date='yesterday' --rfc-3339=date).md"

  NOTES_DIR="$HOME/notes"
  JOURNAL_DIR="$NOTES_DIR/journal"

  # Use the directory of the file being opened as `pwd` rather than that of the
  # spawning terminal.
  VIM_CD='+lcd %:p:h'

  PARAMS=(
    "$NOTES_DIR/todo.txt"          # First, open up my todo.txt file.
    "$VIM_CD"                      # Then, change `pwd` of that buffer to be $NOTES_DIR.
    "+sp $JOURNAL_DIR/$TODAY"      # Split horizontally and open up a journal entry for today.
    "$VIM_CD"                      # Set our `pwd` to be $JOURNAL_DIR.
    "+vsp $JOURNAL_DIR/$YESTERDAY" # Vertically split the journal entry with yesterday's.
    "$VIM_CD"                      # Set our `pwd` to be $JOURNAL_DIR.
  )

  nvim "${PARAMS[@]}"
}
