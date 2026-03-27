# Getting Started

This guide helps you go from clone to verified setup quickly and safely.

## 1) Clone and inspect options

```bash
git clone https://github.com/dmoliveira/utils-scripts.git
cd utils-scripts
make help
```

## 2) Choose your installer

```bash
make install-mac
# optional macOS desktop extras
make install-mac-desktop
# or
make install-debian
# or
make install-unix
```

If you want a preview before changing your machine, run the installer script with `--dry-run`.
For the extra macOS desktop apps, use `./install_my_programs_mac --desktop-extras --dry-run`.

On macOS, the installer also syncs the repo-managed terminal and editor setup into your home directory, including Zsh, tmux, Starship, Neovim, WezTerm, Ghostty, a default JankyBorders config, the Codex template config, and helper scripts under `~/.local/bin`.

### Optional macOS window tools

Run `make install-mac ARGS="--desktop-extras"` when you also want optional macOS window tools from Homebrew, including `DockDoor`, `Maccy`, `Espanso`, `AppCleaner`, `borders`, `yabai`, and `skhd`.

These are installed but not auto-started by the installer. `borders` reads `~/.config/borders/bordersrc` on launch, so you can tweak the synced theme before starting the service. If you want to use the window-manager services later, start them manually:

```bash
brew services start borders
yabai --start-service
skhd --start-service
```

If you prefer Rectangle or another window manager, you can leave `yabai` and `skhd` installed but disabled.

## 3) Verify your environment

```bash
make verify
make doctor
```

Use `make verify-strict` when you want warnings to fail fast.

## 4) Enable quality gates

```bash
make hooks-install
make pre-commit-install
```

## 5) First productive session

```bash
exec zsh
tmux new -s daily
nvim notes.md
```

## What you get

- shell templates (`zsh`, `starship`, `tmux`)
- practical editor defaults (`nvim`)
- verification and doctor scripts for confidence
- playbooks and cheatsheets for higher throughput

If you get blocked, go to `troubleshooting.md`.
