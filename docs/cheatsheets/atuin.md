# atuin Cheatsheet

Shell history with fast search, optional sync, and command recall workflows.

## Start

```bash
atuin status
atuin history list
```

In this repo template, `atuin` is auto-initialized in zsh:

```zsh
eval "$(atuin init zsh)"
```

## Core commands

```bash
atuin search kubectl
atuin search --cwd make
atuin history list --limit 50
atuin stats
```

## Useful interactive flow

Press `Ctrl-r` in zsh to open Atuin search UI and recall prior commands.

Typical loop:
1. hit `Ctrl-r`
2. type part of command/context
3. select command and execute/edit

## Scoped history patterns

```bash
atuin search --cwd verify
atuin search --exclude-exit 0
atuin search --limit 20 trivy
```

Use `--cwd` when you want history relevant to the current project only.

## Sync commands (optional)

```bash
atuin login
atuin sync
atuin logout
```

Use sync only if you want cross-machine history portability.

## Practical productivity workflows

### Flow 1: recover complex kubectl command

```bash
atuin search kubectl
```

Reuse prior multi-flag command instead of reconstructing manually.

### Flow 2: repeat quality gate sequence

```bash
atuin search "make verify"
```

Great for repeated local PR prep loops.

### Flow 3: incident command recall

```bash
atuin search --cwd "doggo"
atuin search --cwd "k9s"
```

Find prior triage commands used in this repository.

## Troubleshooting

### Atuin not active in shell

```bash
command -v atuin
grep -n "atuin init zsh" ~/.zshrc
```

### No expected history entries

- ensure shell session includes Atuin init
- rerun command once and search again
