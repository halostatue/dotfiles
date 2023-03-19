#!/bin/bash
# <xbar.title>Homebrew Updates</xbar.title>
# <xbar.author>killercup</xbar.author>
# <xbar.author.github>killercup</xbar.author.github>
# <xbar.desc>List available updates from Homebrew (OS X)</xbar.desc>

exit_with_error() {
  echo "err | color=red"
  exit
}

declare brew

brew=$(type -P brew)

if [[ -z "${brew}" ]]; then
  for v in ~/.brew/bin /opt/homebrew/bin /usr/local/bin; do
    if [[ -x "${v}"/brew ]]; then
      brew="${v}"/brew
      break
    fi
  done
fi

"${brew}" update >/dev/null || exit_with_error

PINNED=$("${brew}" list --pinned)
OUTDATED=$("${brew}" outdated --quiet)

UPDATES=$(comm -13 <(for X in "${PINNED[@]}"; do echo "${X}"; done) <(for X in "${OUTDATED[@]}"; do echo "${X}"; done))

UPDATE_COUNT=$(echo "$UPDATES" | grep -c '[^[:space:]]')

echo "↑$UPDATE_COUNT | dropdown=false"
echo "---"
if [ -n "$UPDATES" ]; then
  echo "Upgrade all | shell=${brew} param1=upgrade terminal=false refresh=true"
  echo "$UPDATES" | awk -v brew="${brew}" '{print $0 " | terminal=false refresh=true shell=$brew param1=upgrade param2=" $1}'
fi
