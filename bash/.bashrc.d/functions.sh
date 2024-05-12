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

# A quick and dirty way to create an encrypted export of $HOME to store on
# untrusted cloud storage.
#
# This is intended to be a secondary mechanism that acts as a conservative
# sanity check of sorts, whereas we have better backup tools being run more
# regularly (e.g. `kopia`).
#
# TL;DR: This is a backup backup, so that we don't have to place our trust in
# any one tool (e.g. if Kopia repository gets corrupted).
#
# Currently assumes it's being run interactively, while the invoker is present
# (symmetric encryption key).
snapshot_homedir() {
  BACKUP_DIR="/tmp/manual-snapshots"

  BACKUP_FILE="$(date --rfc-3339=date)_${USER}@${HOSTNAME}.tar.zst"
  ENCRYPTED_FILE="${BACKUP_FILE}.gpg"

  BACKUP_PATH="${BACKUP_DIR}/${BACKUP_FILE}"
  ENCRYPTED_PATH="${BACKUP_DIR}/${ENCRYPTED_FILE}"

  # Ensure the necessary dependencies exist.
  for cmd in tar zstd gpg; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "$cmd could not be found. Please install it and try again."
      return 1
    fi
  done

  mkdir -p "${BACKUP_DIR}"

  echo "Creating archive at ${BACKUP_PATH}..."
  if ! tar --zstd -cpf "${BACKUP_PATH}" "${HOME}"; then
    echo "Error: failed to create archive at ${BACKUP_PATH}."
    return 1
  fi

  echo "Encrypting archive as ${ENCRYPTED_PATH}..."
  if ! gpg --symmetric --cipher-algo AES256 "${BACKUP_PATH}"; then
    echo "Error: failed to encrypt archive at ${BACKUP_PATH}."

    # Clean up unencrypted file if encryption fails.
    echo "Removing ${BACKUP_PATH}..."
    rm "${BACKUP_PATH}"
    return 1
  fi

  echo "Removing unencrypted archive ${BACKUP_PATH}..."
  rm "${BACKUP_PATH}"

  echo "Encrypted backup complete: ${ENCRYPTED_PATH}"
}
