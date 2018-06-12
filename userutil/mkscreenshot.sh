#!/usr/bin/env sh
TMPFILE="$(mktemp)"
OUTFILE="${TMPFILE%/*}/$(date +%s).png"

finish() {
    rm -f "$TMPFILE"
}
trap finish EXIT

MAIM=(maim --format=png --hidecursor $TMPFILE)
CRUSH=(pngcrush -rem alla -reduce $TMPFILE $OUTFILE)

while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        -s|--select)    MAIM+=(--select);;
    esac
    shift
done

"${MAIM[@]}"
"${CRUSH[@]}"

