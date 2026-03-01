# zsh Cheatsheet

Practical shell flow for this repository templates.

## Reload and validate

```bash
exec zsh
zsh -n ~/.zshrc
zsh -n run_commands/my_zshrc
```

## Useful patterns

```bash
set -o | rg -n 'interactive|monitor'
autoload -Uz compinit && compinit
typeset -f leader-pack-help
```

## Common aliases and helpers

- `leader-pack-help`
- `tmux-research`
- `tmux-delivery`
- `tmux-incident`
- `ghostty-reload`

## Safety

- keep secrets in `~/.config/secrets/shell.env`
- set strict permissions with `chmod 600 ~/.config/secrets/shell.env`
- avoid committing secrets and tokens
