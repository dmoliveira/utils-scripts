# zellij Cheatsheet

Terminal workspace manager with built-in panes, tabs, and session restore support.

## Start

```bash
zellij
```

## Core keys

Zellij uses `Ctrl-g` as the mode-prefix by default.

```text
Ctrl-g ?      open keybinding help
Ctrl-g d      detach session
Ctrl-g n      new pane
Ctrl-g x      close pane
Ctrl-g f      toggle fullscreen pane
Ctrl-g [h/j/k/l] move focus between panes
Ctrl-g t      new tab
Ctrl-g w      close tab
```

## Session workflows

```bash
zellij attach -c main
zellij list-sessions
zellij kill-session main
```

## Practical workflows

### Flow 1: coding workspace

```bash
zellij
# split panes for editor / tests / git
```

Suggested layout:
- pane 1: `nvim .`
- pane 2: `make verify`
- pane 3: `lazygit`

### Flow 2: incident triage workspace

```bash
zellij
```

Suggested tabs:
- tab 1: `btop` + `procs --sortd cpu`
- tab 2: `k9s`
- tab 3: `doggo service.internal A`

### Flow 3: reproducible named session

```bash
zellij attach -c ops
```

Reuse named sessions to keep context between restarts.

## Troubleshooting

### command not found

```bash
command -v zellij
make verify
```

### forgot keybindings

```text
Ctrl-g ?
```

### reset a stuck layout

Detach and reattach session:

```bash
zellij list-sessions
zellij attach <session-name>
```
