# gh Cheatsheet

High-leverage GitHub CLI workflows for PRs, reviews, and issue management.

## Authentication and setup

```bash
gh auth status
gh auth login
gh repo view
```

## Pull request workflows

```bash
gh pr status
gh pr create --title "..." --body "..."
gh pr view 123
gh pr checks 123 --watch
gh pr merge 123 --squash --delete-branch
```

## Branch + PR flow (daily)

```bash
git checkout -b feature/foo
# code + commit + push
gh pr create --fill
gh pr checks --watch
gh pr merge --squash --delete-branch
```

## Reviews and comments

```bash
gh pr review 123 --approve
gh pr review 123 --request-changes --body "Please fix ..."
gh pr comment 123 --body "Looks good after updates"
```

## Issue workflows

```bash
gh issue list
gh issue view 42
gh issue create --title "..." --body "..."
gh issue comment 42 --body "Update: fixed in PR #..."
```

## Useful query patterns

```bash
gh pr list --state open --author @me
gh pr list --search "is:open label:bug"
gh issue list --label enhancement --state open
```

## API access for advanced usage

```bash
gh api repos/dmoliveira/utils-scripts/pulls/1
gh api repos/dmoliveira/utils-scripts/pulls/1/comments
```

## Practical team flows

### Flow 1: fast PR landing

1. `gh pr create --fill`
2. `gh pr checks --watch`
3. `gh pr merge --squash --delete-branch`

### Flow 2: reviewer loop

1. `gh pr list --search "review-requested:@me"`
2. `gh pr view <id>`
3. `gh pr review <id> --approve` (or request changes)

### Flow 3: issue-to-PR traceability

1. reference issue in commit/PR body (`closes #123`)
2. comment on issue with PR link using `gh issue comment`

## Troubleshooting

### Not authenticated

```bash
gh auth login
gh auth status
```

### Wrong repo context

```bash
gh repo view
gh repo set-default owner/repo
```
