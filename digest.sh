#!/bin/sh

SINCE="$1"

START=$(git rev-list --since "$SINCE" --reverse master | head -n 1)
PRETTY_SINCE=$(date -j -f "%Y-%m-%dT%H:%M" "${SINCE}" +"%Y-%m-%d")
echo "*EMOJI DIGEST! (v0.0.2)*"
echo "New emoji since ${PRETTY_SINCE}:"
git diff "${START}^..master" -- list.txt | grep '^[+-][^+-]' | awk '
BEGIN {
  imagematcher = "https:.+"
  aliasmatcher = "alias:.+"
}
match ($2, imagematcher) {
  name = substr($1, 2)
  printf ":%s: `:%s:`\n", name, name
}
match ($2, aliasmatcher) {
  name = substr($1, 2)
  target = substr($2, RSTART+6, RLENGTH-6)
  printf ":%s: `:%s:` (alias for `:%s:`)\n", name, name, target
}
'
