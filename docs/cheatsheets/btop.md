# btop Cheatsheet

High-value `btop` commands and workflows for day-to-day engineering monitoring.

## Start

```bash
btop
```

## Core keys

```text
Esc / q      quit
h            toggle help
f            filter processes
s            sort menu
r            reverse sort order
k            send signal / kill process
m            toggle memory graph style
n            toggle network panel
d            toggle disk panel
```

## Fast process triage

1. Open `btop`
2. Focus process panel
3. Press `s` and sort by CPU or memory
4. Press `f` and filter by process name (e.g. `python`, `node`, `nvim`)
5. Use `k` only when you are sure about the target process

## Engineering workflows

### Flow 1: slow test/build investigation

```bash
make verify
btop
```

Watch CPU saturation, memory spikes, and process fan-out while checks run.

### Flow 2: model training sanity check

```bash
python train.py
btop
```

Use process + memory panels to verify expected resource behavior and detect runaway jobs.

### Flow 3: incident response companion

```bash
tmux-incident
btop
```

Combine with `procs --sortd cpu` and `k9s` for system + cluster triage.

## Useful companion commands

```bash
procs --sortd cpu
procs python
dust -d 3
```

## Troubleshooting

### `btop` not found

Run installer or verify path:

```bash
command -v btop
make verify
```

### Need lightweight fallback

```bash
htop
```
