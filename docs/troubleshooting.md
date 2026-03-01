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

## Hooks not active

Run:

```bash
make hooks-install
make pre-commit-install
```

## tmux status labels show but values are blank

Run:

```bash
make verify
~/.tmux/plugins/tpm/bin/install_plugins
brew install coreutils # macOS only
```

Then reload tmux config with `Ctrl-b r`.

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
