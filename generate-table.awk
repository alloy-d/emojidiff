#!/usr/bin/awk -f
BEGIN {
  imagematcher = "https:.+"
  aliasmatcher = "alias:.+"
  print "| name | image |"
  print "| ---- | ----- |"
}
match ($2, imagematcher) {
  printf "| <a name=\"%s\">`:%s:`</a> | <img src=\"%s\" /> |\n", $1, $1, $2
}
match ($2, aliasmatcher) {
  target = substr($2, RSTART+6, RLENGTH-6)
  printf "| <a name=\"%s\">`:%s:`</a> | alias for <a href=\"#%s\">`:%s:`</a> |\n", $1, $1, target, target
}
