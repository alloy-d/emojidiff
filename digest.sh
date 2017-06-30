#!/bin/sh

SINCE="$1"

START=$(git rev-list --since "$SINCE" --reverse master | head -n 1)
git diff "${START}^..master" -- list.txt | grep '^[+-][^+-]' | awk '
BEGIN {
  imagematcher = "https:.+"
  aliasmatcher = "alias:.+"
  print "*EMOJI DIGEST v0.0.1*"
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
