# tmux Cheatsheet

Practical tmux commands and flows tuned for this repo.

## Start and attach

```bash
tmux new -s main
tmux attach -t main
tmux ls
tmux kill-session -t main
```

## Core keys (prefix `Ctrl-b`)

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

```text
●   window has new activity/output
!   bell/urgent event
```

Idle windows show no marker; activity markers only appear when there is new output.

## Status line example

When QoL status plugins are enabled, the right side can show CPU, memory, network,
battery (when available), and time:

```text
CPU 12.3% MEM 45.6% NET ↓120KiB/s • ↑90KiB/s BAT 89% 2026-03-01 23:40
```

If `NET` is blank, run `make verify` to check tmux plugin health and `numfmt` availability.

## Copy/clipboard flow

```text
Ctrl-b [      enter copy mode
v             begin selection (copy-mode-vi)
y             copy selection to system clipboard
Enter         copy selection to system clipboard
```

## Validate config quickly

```bash
tmux -L utils-scripts-smoke -f ~/.tmux.conf new-session -d -s smoke
tmux -L utils-scripts-smoke kill-server
```
