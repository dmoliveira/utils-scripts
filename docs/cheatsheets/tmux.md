# tmux Cheatsheet

Practical tmux commands and flows tuned for the `utils-scripts` setup.

## Start and attach

```bash
tmux new -s main
tmux attach -t main
tmux ls
tmux kill-session -t main
```

Template shortcut from `~/.zshrc`:

```bash
tm
```

## Core keybindings (default prefix `Ctrl-b`)

```text
Ctrl-b c      new window
Ctrl-b n/p    next/previous window
Ctrl-b ,      rename window
Ctrl-b %      split pane vertically
Ctrl-b "      split pane horizontally
Ctrl-b o      switch pane
Ctrl-b z      zoom/unzoom pane
Ctrl-b d      detach session
Ctrl-b r      reload ~/.tmux.conf
```

## Activity highlighting

The repo tmux template highlights windows when output lands in a background window.

```text
*   window has new activity/output
!   bell/urgent event (if emitted by the process)
:   no new event (idle marker)
```

If your command does not emit a bell, you still get the `*` activity marker.
If Powerline is unavailable, the config falls back to a native tmux status line.
The defaults keep notifications non-intrusive: badges update in the window list without visual popup/bell overlays.
Default labels use mixed markers (`* `, `! `) for stronger cues.
Markers are shown before each background window index when activity (`*`) or bell (`!`) is present.

If your font has glyph issues, switch to safe symbols:

```text
set -g @status_use_nerd_fonts 'off'
```

If your font fully supports Nerd glyphs, set `@status_use_nerd_fonts` to `on`.

Richer status (CPU + battery) is enabled by default:

```text
set -g @qol_status_plugins 'on'   # set to 'off' for minimal status-right
```

With this switch enabled, status-right includes CPU and memory metrics.
Battery is shown only when a battery percentage is available.

## Copy and clipboard flow

This repo config includes clipboard-aware copy-mode mappings.

```text
Ctrl-b [      enter copy mode
v             begin selection (copy-mode-vi)
y             copy selection to system clipboard
Enter         copy selection to system clipboard
```

## Session persistence

The template enables `tmux-resurrect` + `tmux-continuum`.

```text
Ctrl-b I      install TPM plugins (first run)
Ctrl-b U      update TPM plugins
Ctrl-b M-s    save tmux environment (resurrect)
Ctrl-b M-r    restore tmux environment (resurrect)
```

## High-value leadership flows

### Research mode

```bash
tmux-research
```

Use this when benchmarking and exploring code:
- editor in first window
- git review window (`lazygit`)
- benchmark window (`hyperfine`)
- monitor window (`btop`)

### Delivery mode

```bash
tmux-delivery
```

Use this when finalizing changes:
- editor + live verify split
- git review window
- security scan window (`trivy`)

### Incident mode

```bash
tmux-incident
```

Use this when troubleshooting production issues:
- system monitor + process view
- k8s window (`k9s`/`kubectl`)
- network diagnostics (`doggo`)

## Daily command sequence

```bash
tmux new -A -s main
nvim .
make verify
lazygit
```

## Validate tmux config quickly

```bash
tmux -L utils-scripts-smoke -f ~/.tmux.conf new-session -d -s smoke
tmux -L utils-scripts-smoke kill-server
```
