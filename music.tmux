#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Helper functions to read/write tmux options
get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

set_tmux_option() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
}

do_interpolation() {
    local string="$1"
    local interpolated="${string//\#\{plexamp_track\}/\#($CURRENT_DIR\/scripts\/track.sh track)}"
    interpolated="${interpolated//\#\{plexamp_artist\}/\#($CURRENT_DIR\/scripts\/track.sh artist)}"
    interpolated="${interpolated//\#\{plexamp_album\}/\#($CURRENT_DIR\/scripts\/track.sh album)}"
    interpolated="${interpolated//\#\{plexamp_status\}/\#($CURRENT_DIR\/scripts\/track.sh status)}"
    interpolated="${interpolated//\#\{plexamp_icon\}/\#($CURRENT_DIR\/scripts\/track.sh icon)}"
    echo "$interpolated"
}

update_tmux_option() {
    local option="$1"
    local option_value="$(get_tmux_option "$option")"
    local new_option_value="$(do_interpolation "$option_value")"
    set_tmux_option "$option" "$new_option_value"
}

main() {
    update_tmux_option "status-right"
    update_tmux_option "status-left"
}

main
