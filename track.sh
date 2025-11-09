#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE_FILE="/tmp/tmux_plexamp_cache.txt"
MAX_CACHE_AGE=3 # Re-run applescript if cache is older than 3 seconds

refresh_cache() {
	osascript "$CURRENT_DIR/track.applescript" >"$CACHE_FILE"
}

if [ -f "$CACHE_FILE" ]; then
	CURRENT_TIME=$(date +%s)
	FILE_TIME=$(stat -f "%m" "$CACHE_FILE")
	AGE=$((CURRENT_TIME - FILE_TIME))
	if [ $AGE -gt $MAX_CACHE_AGE ]; then
		refresh_cache
	fi
else
	refresh_cache
fi

IFS=$'\n' read -d '' -r -a DATA <"$CACHE_FILE"

# Data map based on applescript output order:
# Line 1 (Index 0): Title (or "stopped")
# Line 2 (Index 1): Artist
# Line 3 (Index 2): Album
# Line 4 (Index 3): isPlaying (true/false)

if [ "${DATA[0]}" == "stopped" ] || [ "${#DATA[@]}" -lt 4 ]; then
	echo ""
	exit 0
fi

case "$1" in
"track")
	echo "${DATA[0]}"
	;;
"artist")
	echo "${DATA[1]}"
	;;
"album")
	echo "${DATA[2]}"
	;;
"status")
	echo "${DATA[3]}"
	;;
"icon")
	if [ "${DATA[3]}" == "true" ]; then
		echo "▶"
	else
		echo "⏸"
	fi
	;;
*)
	echo "${DATA[1]} - ${DATA[0]}"
	;;
esac
