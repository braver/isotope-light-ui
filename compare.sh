#!/bin/bash

# Use this script to compare files from isotope-ui with isotope-light-ui.

abort() {
    cleanup
    echo $'\e[1;31merror:' "$1" $'\e[0m' >&2
    exit 1
}

hr() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

cleanup() {
    [[ -n "$diff_output" ]] && rm -f "$diff_output"
}

show() {
    hr
    echo "$(tput bold)$1$(tput sgr0)"
    if type pygmentize >/dev/null 2>&1; then
        cat "$diff_output" | pygmentize -l diff -f terminal256
    else
        cat "$diff_output"
    fi
    echo
}

compare() {
    file="$1"
    LHS="$(realpath "$file")"
    RHS="$ISOTOPE_UI_PATH/$file"
    [[ -n "$2" ]] && RHS="$ISOTOPE_UI_PATH/$2"
    if [[ -e $RHS && -e $LHS ]]; then
        diff -u \
            <(sed 's/isotope-light-ui/isotope-ui/g' "$LHS") \
            <(cat "$RHS") \
            >"$diff_output"
        if [[ $? == 0 ]]; then
            return
        else
            show "$file"
        fi
    elif [[ -e $RHS ]]; then
        echo "$(tput bold)new file: $file$(tput sgr0)"
    elif [[ -e $LHS ]]; then
        echo "$(tput bold)delete file: $file$(tput sgr0)"
    fi
}

ISOTOPE_UI_PATH="$1"
[[ -e "$ISOTOPE_UI_PATH" ]] || abort "usage: ${0##*/} ISOTOPE-UI-PATH"
ISOTOPE_UI_PATH="$(realpath "$ISOTOPE_UI_PATH")"
diff_output=$(mktemp -t tmp.XXXXXXXXXX.log.diff)
echo $diff_output
trap 'rm -f $diff_output' EXIT
compare "index.less"
for file in styles/*; do
    compare "$file"
done
compare "lib/isotope-light-ui.coffee" "lib/isotope-ui.coffee"
cleanup
