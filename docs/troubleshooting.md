# Troubleshooting

## Verification fails

Run:

```bash
make doctor
```

Then resolve failures and re-run `make verify`.

## Linux command variants (`fd` vs `fdfind`, `bat` vs `batcat`)

Run:

```bash
make verify-linux
```

## Ghostty validation issues

Run:

```bash
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config --config-file ~/.config/ghostty/config
```

If remote hosts support `xterm-ghostty`, prefer Ghostty's default `TERM` value so tmux can detect
clipboard support cleanly. Only fall back to `xterm-256color` when the remote machine is missing
Ghostty terminfo.

## Hooks not active

Run:

```bash
make hooks-install
make pre-commit-install
```

## tmux status labels show but values are blank

Run:

```bash
make tmux-self-heal
make verify
```

Then reload tmux config with `Ctrl-b r`.

## SSH clipboard copy fails inside tmux, Neovim, or OpenCode

Use tmux copy-mode (`Ctrl-b [` then `v`, `y`) after reloading the config with `Ctrl-b r`.
The repo enables OSC52 so remote copies can reach the local terminal clipboard over SSH.

Important: this workflow is intended for trusted remote hosts. The tmux setting that makes Neovim
and similar apps copy cleanly over SSH also allows apps inside that tmux session to write to your
local clipboard.

Quick checks:

```bash
echo "$TERM"
tmux show -s set-clipboard
tmux show -g terminal-features
```

Expected results:

- `TERM` stays `xterm-ghostty` when the remote host has Ghostty terminfo installed.
- `set-clipboard` is `on`.
- `terminal-features` includes `clipboard` for `xterm-ghostty` or `xterm-256color`.

## `make shell-lint` fails with `mapfile: command not found`

Update to the latest release. The shell lint pipeline now supports Bash 3.x environments (for example, default macOS `/bin/bash`).

## Need to revert installer changes

Run:

```bash
make rollback-dry-run
make rollback
```

## Secrets file not loaded

Ensure file exists and permissions are strict:

```bash
chmod 600 ~/.config/secrets/shell.env
make bootstrap-secrets
```
