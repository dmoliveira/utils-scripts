# rg Cheatsheet

Fast code/content search with practical filters for large repositories.

## Start

```bash
rg "TODO"
```

## Core patterns

```bash
rg "function\s+init"
rg "error|failed|panic"
rg "class\s+\w+" src
rg "TODO" -g "*.md"
rg "install_my_programs" -g "*.sh"
```

## Useful flags

```text
-n              show line numbers
-i              case-insensitive search
-S              smart case
-g "glob"      include/exclude file globs
--hidden        include hidden files
--glob '!.git'  exclude path
--count         count matches by file
```

Examples:

```bash
rg -n "br ready" README.md
rg -i "starship" run_commands
rg --count "TODO" -g "*.md"
```

## Practical workflows

### Flow 1: find config references quickly

```bash
rg -n "tmux-research|tmux-delivery|tmux-incident"
```

### Flow 2: locate legacy wording before cleanup

```bash
rg -n "bd\b|beads" -g "*.md"
```

### Flow 3: scoped docs update pass

```bash
rg -n "cheatsheets" README.md TERMINAL_PLAYBOOK.md docs/cheatsheets
```

## Regex workflows

```bash
rg -n "<leader>[a-z]{2}"
rg -n "^## " docs/cheatsheets
```

## Companion commands

```bash
fd -e md
rg -n "pattern" -g "*.md"
```

Use `fd` to narrow files, then `rg` for content.

## Troubleshooting

### Too many results

- scope to directory/path
- add `-g` glob filters
- use more specific regex

### Need hidden files

```bash
rg --hidden --glob '!.git' "pattern"
```
