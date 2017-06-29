#!/bin/bash
set -euo pipefail

if [ -z "$SLACK_API_TOKEN" ]; then
  echo "Please set \$SLACK_API_TOKEN!" >&2
  exit 1
fi

TMPFILE=$(mktemp)
if [ $? -ne 0 ]; then
  echo "Error: couldn't create a temporary file. :-/" >&2
  exit 2
fi

curl -so "${TMPFILE}" "https://slack.com/api/emoji.list" --data-urlencode "token=${SLACK_API_TOKEN}"

# Slack API returns an "ok" field that represents whether the request
# was successful.
jq .ok -e < "$TMPFILE" >/dev/null

jq '.emoji | to_entries | map(.key + " " + .value) | .[]' -Sr < "$TMPFILE" | sort
