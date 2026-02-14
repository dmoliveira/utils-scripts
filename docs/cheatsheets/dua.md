# dua Cheatsheet

Fast disk-usage triage with interactive navigation.

## Start

```bash
dua i
```

`dua i` opens interactive mode to quickly find large directories/files.

## Core commands

```bash
dua i
dua .
dua ~/Downloads
```

## Practical workflows

### Flow 1: repo bloat check

```bash
dua i .
```

Look for heavy folders like `node_modules`, build artifacts, caches, or large datasets.

### Flow 2: home directory cleanup

```bash
dua i ~
```

Drill into `Downloads`, old virtualenvs, and stale archives.

### Flow 3: before/after cleanup validation

```bash
dua .
# clean files
dua .
```

Run twice to confirm space reclaimed after cleanup.

## Companion commands

```bash
dust -d 3
du -sh *
```

Use `dust` for a quick summary and `dua i` for deep interactive exploration.

## Safe cleanup pattern

1. identify large targets with `dua i`
2. verify they are safe to remove
3. delete intentionally
4. rerun `dua i` to confirm impact

## Troubleshooting

### command not found

```bash
command -v dua
make verify
```

### need non-interactive quick summary

```bash
dust -d 3
```
