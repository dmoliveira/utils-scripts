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
