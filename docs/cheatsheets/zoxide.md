# zoxide Cheatsheet

Fast directory jumping based on frecency (frequency + recency).

## Start

```bash
zoxide query utils-scripts
```

In this repo template, zoxide is auto-initialized in zsh:

```zsh
eval "$(zoxide init zsh)"
```

## Core commands

```bash
z <term>
zi <term>
z -
zoxide query <term>
zoxide query -i
```

- `z <term>`: jump to best matching directory
- `zi <term>`: interactive selection UI
- `z -`: jump to previous directory

## Practical workflows

### Flow 1: multi-repo switching

```bash
z utils-scripts
z mcp_agent_mail
z my-cmds
```

Reduces repeated long `cd` commands across active repos.

### Flow 2: focused project recall

```bash
zoxide query utils
z utils
```

Use `query` first when name collisions are possible.

### Flow 3: interactive jump during incident

```bash
zi
```

Pick from ranked recent directories when context is fragmented.

## Combined shell productivity

```bash
z utils-scripts
tmux-research
nvim .
```

Use zoxide + tmux templates for very fast startup loops.

## Troubleshooting

### command not found

```bash
command -v zoxide
make verify
```

### unexpected jump target

Use interactive mode to choose explicitly:

```bash
zi <term>
```
