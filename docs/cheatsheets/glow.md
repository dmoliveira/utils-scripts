# Glow Cheatsheet

Practical Glow usage for browsing Markdown docs in terminal.

## Core commands

```bash
glow README.md
glow docs/cheatsheets/tmux.md
```

## Browse docs with preview

```bash
fd -e md docs | fzf --preview 'glow -p {}' --preview-window=right:70%
```

## Follow-up flow

```bash
fd -e md . | fzf --preview 'glow -p {}'
```

Use this to move quickly across repository docs while keeping context.
