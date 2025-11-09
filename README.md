tmux-plexamp
===================
tmux plugin to show your current playing information from plexamp

Requirements
-----------
- only works on MacOS / OSX , this plugin uses applescript.

Installation
------------
### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```
set -g @plugin 'kdssoftware/tmux-plexamp'
```

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-right` or `status-left`, they should now be visible.

Usage
-----

The following commands are available to add to your `.tmux.conf` file:

- `#{plexamp_track}`
- `#{plexamp_artist}`
- `#{plexamp_album}`
- `#{plexamp_status}`  when playing: `true`, when not playing no output
- `#{plexamp_icon}` when playing: `▶`, when not playing `⏸`


(alternative) Use the `track.sh` directly.

- `$HOME/.tmux/plugins/tmux-plexamp/track.sh track`
- `$HOME/.tmux/plugins/tmux-plexamp/track.sh artist`
- `$HOME/.tmux/plugins/tmux-plexamp/track.sh album`
- `$HOME/.tmux/plugins/tmux-plexamp/track.sh status`
- `$HOME/.tmux/plugins/tmux-plexamp/track.sh icon`


References
----------
- https://github.com/tmux-plugins
