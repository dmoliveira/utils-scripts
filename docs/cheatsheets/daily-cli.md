# Daily CLI Cheatsheet

Lean, high-value commands for daily terminal work.

## Data and config

```bash
yq '.jobs.test.steps[].run' .github/workflows/smoke-checks.yml
yq -i '.name = "golden-path-bootstrap"' .github/workflows/golden-path-bootstrap.yml
jq '.[] | {name, private}' repos.json
```

## Shell quality

```bash
shellcheck install_my_programs_unix
shfmt -w install_my_programs_unix install_my_programs_mac install_my_programs_debian
pre-commit run --all-files
```

## Git readability

```bash
git -c core.pager=delta show
git -c core.pager=delta diff
```

## Fast command docs

```bash
tldr tmux
tldr yq
tldr direnv
```

## Markdown workflow

```bash
make docs-browse
mdview README.md
mdfind docs
mdnext docs
```

## Text processing and watch loops

```bash
awk -F: '{print $1}' ~/.zshrc
gawk '/direnv/ {print NR ":" $0}' run_commands/my_zshrc
fd -e md docs | entr -c glow -p README.md
```
