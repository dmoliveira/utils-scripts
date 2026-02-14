# fd Cheatsheet

Fast file discovery for large repos with clean defaults.

## Start

```bash
fd nvim
```

## Core patterns

```bash
fd "\.md$"
fd "test" src
fd -t f "docker"
fd -t d "nvim"
fd -H "^\.env"
```

- `-t f`: files only
- `-t d`: directories only
- `-H`: include hidden files

## Extension and glob filters

```bash
fd -e md
fd -e lua
fd -g "**/*.yml"
fd -g "**/*cheatsheet*"
```

## Practical workflows

### Flow 1: find config quickly

```bash
fd -H "zsh|tmux|starship" run_commands
```

### Flow 2: locate scripts before edits

```bash
fd -e sh
fd "install_my_programs"
```

### Flow 3: pair with grep for fast code search

```bash
fd -e md docs | xargs rg "cheatsheet"
```

## Exclude noisy paths

```bash
fd --exclude .git --exclude node_modules "pattern"
```

## Troubleshooting

### command not found

```bash
command -v fd
make verify
```

### macOS alias differences

Some systems install as `fdfind`; this repo expects `fd` via Homebrew.
