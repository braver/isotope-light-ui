#!/bin/bash

# Use this script to sync files from isotope-ui to isotope-light-ui.

abort() {
    cleanup
    echo $'\e[1;31merror:' "$1" $'\e[0m' >&2
    exit 1
}

ISOTOPE_UI_PATH="$1"
RELATIVE_FILE_PATH="$2"
[[ -e "$ISOTOPE_UI_PATH" && -e "$RELATIVE_FILE_PATH" ]] || abort "usage: ${0##*/} ISOTOPE-UI-PATH RELATIVE-FILE-PATH"

set -e
echo "$(tput bold)Syncing $ISOTOPE_UI_PATH/$RELATIVE_FILE_PATH -> $RELATIVE_FILE_PATH$(tput sgr0)"
cat "$ISOTOPE_UI_PATH/$RELATIVE_FILE_PATH" | sed 's/isotope-ui/isotope-light-ui/g' > "$RELATIVE_FILE_PATH"
