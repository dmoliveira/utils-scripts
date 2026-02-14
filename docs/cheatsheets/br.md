# br Cheatsheet

Task tracking with `beads_rust` using dependency-aware issue workflows.

## Start

```bash
br ready
```

## Core lifecycle

```bash
br ready
br show <id>
br update <id> --status in_progress
br close <id> --reason "Completed"
```

## Create and organize work

```bash
br create --title-flag "Add feature X" -t task -p P2 -d "Scope and outcome"
br dep add <child-id> <parent-id>
br stats
```

- types commonly used: `task`, `bug`, `epic`
- priorities: `P0` (highest) to `P4` (lowest)

## Daily execution flow

1. `br ready` and pick one issue
2. `br update <id> --status in_progress`
3. implement in a worktree branch
4. open PR and merge
5. `br close <id> --reason "..."`

## Sync behavior (important)

`br` is non-invasive and does not run git commands for you.

When needed:

```bash
br sync --flush-only
git add .beads/
git commit -m "sync beads"
```

## Practical team workflows

### Flow 1: run one issue per branch

```bash
br ready
br update <id> --status in_progress
git worktree add ../repo-<id> -b repo-<id>
```

### Flow 2: surface blockers quickly

```bash
br update <id> --status blocked
br show <id>
```

### Flow 3: close with traceability

```bash
gh pr merge <pr> --squash --delete-branch
br close <id> --reason "Merged PR #<pr>"
```

## Troubleshooting

### no ready issues

```bash
br ready
br stats
```

Create a scoped task or unblock dependencies.

### wrong issue context

```bash
br show <id>
```

Verify status/priority/dependencies before working.
