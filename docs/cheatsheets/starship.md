# Starship Cheatsheet

Power-user Starship commands and prompt-tuning flows for this repo.

## Apply and validate config

```bash
mkdir -p ~/.config
cp ./run_commands/my_starship.toml ~/.config/starship.toml
STARSHIP_CONFIG=~/.config/starship.toml starship explain
exec zsh
```

## Core commands

```bash
starship --version
starship print-config
starship explain
```

Use `STARSHIP_CONFIG=/path/to/file` to validate changes before replacing your live config.

## High-value template behavior

- compact git dirtiness counts only when the repo is dirty
- language context appears only when relevant (`python`, `nodejs`, `golang`, `rust`)
- command duration shown after 2s and notifies after 15s
- right-side context keeps prompt body clean (`jobs`, `time`)

## Fast customization examples

### Change prompt character style

```toml
[character]
success_symbol = "[❯](bold #98c379)"
error_symbol = "[✗](bold #e06c75)"
```

### Reduce git noise further

```toml
[git_status]
format = "([$staged$modified$untracked]($style) )"
```

### Show shorter paths

```toml
[directory]
truncation_length = 2
truncate_to_repo = true
```

## Prompt tuning workflow

1. Copy current template to a temporary file.
2. Export `STARSHIP_CONFIG` to that temp file.
3. Run `starship explain` and open a new shell.
4. Iterate until happy.
5. Promote changes into `run_commands/my_starship.toml` via PR.

Example:

```bash
cp run_commands/my_starship.toml /tmp/starship-test.toml
export STARSHIP_CONFIG=/tmp/starship-test.toml
starship explain
exec zsh
```

## Troubleshooting

### Prompt unchanged after edits

```bash
exec zsh
```

### Unknown symbols/icons

- Ensure terminal uses a Nerd Font (for Ghostty, verify font in `~/.config/ghostty/config`).

### Validate repo template directly

```bash
STARSHIP_CONFIG=./run_commands/my_starship.toml starship explain
```
