# procs Cheatsheet

Fast process inspection with readable defaults for development and incident response.

## Start

```bash
procs
```

## Core commands

```bash
procs --sortd cpu
procs --sortd mem
procs python
procs --tree
procs --watch 2
```

## Most useful filters

```bash
procs nvim
procs node
procs docker
```

Use command-name filters to quickly isolate suspicious workloads.

## Practical incident workflows

### Flow 1: CPU spike triage

```bash
procs --sortd cpu
btop
```

1. sort by CPU descending
2. identify top processes
3. cross-check with `btop` before killing anything

### Flow 2: memory leak suspicion

```bash
procs --sortd mem
procs --watch 2
```

Watch process memory growth over time; confirm trend before taking action.

### Flow 3: language-specific job cleanup

```bash
procs python
procs node
```

Quickly find stale training/inference scripts or dev servers.

## Combined engineering loop

```bash
tmux-incident
procs --sortd cpu
kubectl get pods -A
doggo your-service.internal A
```

## Safety notes

- Prefer verifying process identity and parent process before kill actions.
- Use graceful shutdown first when possible.

## Troubleshooting

### `procs` not found

```bash
command -v procs
make verify
```

### Need POSIX fallback

```bash
ps aux | sort -rk 3,3 | head
```
