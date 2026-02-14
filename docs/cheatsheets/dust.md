# dust Cheatsheet

Quick disk-usage summaries for fast cleanup decisions.

## Start

```bash
dust
```

## Core commands

```bash
dust -d 2
dust -d 3
dust ~
dust .
```

- `-d` controls directory depth.
- lower depth gives faster high-level overview.

## Practical workflows

### Flow 1: fast repo size check

```bash
dust -d 2 .
```

Spot large directories like `node_modules`, artifacts, datasets, and caches.

### Flow 2: home cleanup pass

```bash
dust -d 3 ~
```

Identify heavy folders in `Downloads`, old project caches, and virtualenvs.

### Flow 3: before/after cleanup

```bash
dust -d 3 .
# cleanup files
dust -d 3 .
```

## Companion tools

```bash
dua i
du -sh *
```

Use `dust` first for quick summary, then `dua i` for interactive deep drill.

## Troubleshooting

### command not found

```bash
command -v dust
make verify
```

### need more detailed breakdown

Increase depth:

```bash
dust -d 5
```
