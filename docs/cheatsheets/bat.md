# bat Cheatsheet

Readable file viewing with syntax highlighting and git-aware output.

## Start

```bash
bat README.md
```

## Core commands

```bash
bat README.md
bat -n run_commands/my_zshrc
bat --style=plain README.md
bat --paging=never README.md
```

- `-n` shows line numbers
- `--style=plain` disables decorations
- `--paging=never` prints directly to stdout

## Practical workflows

### Flow 1: inspect config files quickly

```bash
bat run_commands/my_tmux.conf
bat run_commands/my_starship.toml
```

### Flow 2: review scripts with line numbers

```bash
bat -n install_my_programs_unix
bat -n verify_post_install_unix
```

### Flow 3: combine with search tools

```bash
rg -n "leader-pack" README.md | bat --language=log
fd -e md docs/cheatsheets | xargs bat --paging=never
```

## Git and diff-friendly usage

```bash
git show --stat | bat --language=diff
git diff | bat --language=diff
```

## Troubleshooting

### command not found

```bash
command -v bat
make verify
```

### no colors in output

Ensure terminal supports color and avoid forcing plain style.
