# lazygit Cheatsheet

High-signal lazygit shortcuts and workflows for rapid review, staging, and PR prep.

## Start

```bash
lazygit
```

## Core navigation

```text
Tab / Shift-Tab   switch panel
j / k             move selection
Enter             open item/details
q                 close panel/back
?                 open key help
```

## Daily commit workflow

```text
space             stage/unstage file or hunk
c                 commit staged changes
P                 push
F                 pull (fetch/rebase flow)
```

Suggested sequence:
1. review changed files in Files panel
2. stage intentionally (`space`)
3. commit (`c`) with clear message
4. push (`P`)

## Branch and PR prep

```text
b                 open branches panel
n                 new branch
d                 delete branch
o                 checkout selected branch
```

PR preparation flow:
1. create feature branch (`b` -> `n`)
2. commit in focused chunks
3. push branch (`P`)
4. open PR with `gh pr create` in terminal

## Review and diff workflow

```text
e                 open file in editor
d                 open diff view
shift+space       stage file from list
```

Use with repo checks:

```bash
make verify
make shell-lint
lazygit
```

## Useful combined flows

### Flow 1: fast fix and ship

```bash
make verify
lazygit
# stage -> commit -> push
gh pr create
```

### Flow 2: cleanup before merge

```bash
lazygit
# inspect stale branches in branches panel
# switch/delete safely
```

## Troubleshooting

### Push rejected

```bash
git pull --rebase
lazygit
```

### Wrong files staged

- unstage with `space` in Files panel
- recommit after verification
