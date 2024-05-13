#!/usr/bin/env bash
# vim: shiftwidth=2 tabstop=2 expandtab:

VIM_CD='+lcd %:p:h'

# [q]uick [n]ote
#
# Open an ephemeral scratchpad for quick thoughts.
qn() {
  nvim "$VIM_CD" "$NOTES_DIR/tmp.md"
}

# Use todo.txt spec to capture todos.
todo() {
  nvim "$VIM_CD" "$NOTES_DIR/todo.txt"
}

# Open a new journal entry, e.g. journal/2022-07-23.md
jrnl() {
  nvim "$VIM_CD" "$JOURNAL_DIR/$(date --rfc-3339=date).md"
}

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
  # Assumes there's a backup staging dir at `/manual-backups`.
  #
  # NOTE: Originally used tmpfs, but not enough space.
  BACKUP_DIR="/manual-backups"

  # Ensure the above directory exists and is writable.
  #
  # Would rather fail then ask for superuser privileges.
  if [ ! -d "$BACKUP_DIR" ]; then
    echo "Error: backup directory $BACKUP_DIR does not exist."
  elif [ ! -w "$BACKUP_DIR" ]; then
    echo "Error: backup directory $BACKUP_DIR is not writable. Check your permissions."
    return 1
  fi

  BACKUP_FILE="$(date --rfc-3339=date)_${USER}@${HOSTNAME}.tar.zst"
  ENCRYPTED_FILE="${BACKUP_FILE}.gpg"

  BACKUP_PATH="${BACKUP_DIR}/${BACKUP_FILE}"
  ENCRYPTED_PATH="${BACKUP_DIR}/${ENCRYPTED_FILE}"

  # List of directories to exclude from the backup, worthless/problematic.
  EXCLUDE_DIRS=(
    "${HOME}/.cache"
    "${HOME}/.config/BraveSoftware"
    "${HOME}/.config/google-chrome-unstable"
    "${HOME}/.local/share"
    "${HOME}/.mozilla"
    "${HOME}/.npm"
    "${HOME}/.var"
  )

  # Ensure the necessary dependencies exist.
  for cmd in tar zstd gpg; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Error: $cmd could not be found."
      return 1
    fi
  done

  echo "Creating archive at ${BACKUP_PATH}..."

    # Construct the tar command with exclusions
  TAR_CMD=(tar --zstd -cpf "${BACKUP_PATH}")

  for EXCLUDE_DIR in "${EXCLUDE_DIRS[@]}"; do
    TAR_CMD+=(--exclude="$EXCLUDE_DIR")
  done

  # Last: the actual dir (homedir) to back up.
  TAR_CMD+=("${HOME}")

  echo "${TAR_CMD[@]}"

  if ! "${TAR_CMD[@]}"; then
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
