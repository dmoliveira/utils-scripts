# uv Cheatsheet

Fast Python environment and package workflows with `uv`.

## Start

```bash
uv --version
```

## Core environment commands

```bash
uv venv
uv venv .venv
source .venv/bin/activate
```

Use explicit env paths when managing multiple projects.

## Package management

```bash
uv pip install -r requirements.txt
uv pip install ruff pytest
uv pip freeze
uv pip uninstall <package>
```

## Run commands without activating env

```bash
uv run python script.py
uv run pytest -q
uv run ruff check .
```

Great for CI-like reproducible local runs.

## Tooling workflows

### Flow 1: quick project bootstrap

```bash
uv venv .venv
uv pip install -r requirements.txt
uv run pytest -q
```

### Flow 2: lint + test loop

```bash
uv run ruff check .
uv run ruff format .
uv run pytest -q
```

### Flow 3: one-off script execution

```bash
uv run python scripts/sync_data.py
```

## Requirements maintenance

```bash
uv pip install -r requirements.txt
uv pip freeze > requirements.lock.txt
```

## Troubleshooting

### command not found

```bash
command -v uv
make verify
```

### wrong interpreter/environment

Check active environment and run with `uv run` for deterministic behavior.
