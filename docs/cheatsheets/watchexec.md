# watchexec Cheatsheet

Fast edit-run loops for tests, linters, and build checks.

## Start

```bash
watchexec -e py 'pytest -q'
```

## Core patterns

```bash
watchexec -e py 'pytest -q'
watchexec -e sh,lua,md 'make verify'
watchexec -w src -e ts 'npm test'
```

## Useful flags

```text
-e, --exts       file extensions to watch
-w, --watch      watch specific directory
--ignore         ignore paths/patterns
--restart        restart command on new changes
--clear          clear screen between runs
```

Examples:

```bash
watchexec --clear --restart -e py 'pytest -q'
watchexec -w . --ignore .git --ignore .venv -e py,sh 'make verify'
```

## Practical workflows

### Flow 1: test-driven loop

```bash
watchexec --restart -e py 'pytest -q tests/unit'
```

### Flow 2: repo quality loop

```bash
watchexec --clear -e py,sh,lua,md 'make shell-lint && make verify'
```

### Flow 3: docs + scripts iteration

```bash
watchexec -e md,sh 'make leader-pack-check'
```

## tmux integration

Run inside delivery session split:

```bash
tmux-delivery
```

Template already uses `watchexec` when available for live verification loops.

## Troubleshooting

### command not found

```bash
command -v watchexec
make verify
```

### loop too noisy

- narrow watched paths with `-w`
- reduce file types with `-e`
- ignore cache/build dirs with `--ignore`
