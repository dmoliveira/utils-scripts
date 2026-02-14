# Ghostty Cheatsheet

Fast configuration, validation, and workflow tips for Ghostty on macOS.

## Start

```bash
ghostty --version
```

If `ghostty` is not on `PATH`, use:

```bash
/Applications/Ghostty.app/Contents/MacOS/ghostty --version
```

## Core config paths

```text
~/.config/ghostty/config
run_commands/my_ghostty_config
```

## Validate config before reload

```bash
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config --config-file "$HOME/.config/ghostty/config"
```

## Fast edit workflow

This repo template provides:

```bash
ghostty-reload
```

It validates config then opens it in `$EDITOR`.

## Practical tuning examples

```conf
font-family = CaskaydiaCove Nerd Font
font-size = 12.5
theme = Tokyo Night
```

## Apply template from repo

```bash
mkdir -p ~/.config/ghostty
cp ./run_commands/my_ghostty_config ~/.config/ghostty/config
```

## Troubleshooting

### `ghostty: command not found`

Create symlink:

```bash
mkdir -p ~/.local/bin
ln -sf "/Applications/Ghostty.app/Contents/MacOS/ghostty" ~/.local/bin/ghostty
```

### config changes not visible

- run `ghostty-reload`
- open a new Ghostty tab/window if needed

### font name not recognized

- use installed Nerd Font family name exactly
- validate with `+validate-config` before reopening
