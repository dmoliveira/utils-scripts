# hyperfine Cheatsheet

Reliable command benchmarking with practical defaults for engineering workflows.

## Start here

```bash
hyperfine 'python -V' 'uv run python -V'
```

## Most useful flags

```text
--warmup N        run N warmup executions before timing
--runs N          fixed number of measured runs
--min-runs N      minimum runs (auto-calculated beyond this)
--prepare CMD     run setup command before each benchmark
--cleanup CMD     run cleanup command after each benchmark
--export-markdown FILE
--export-json FILE
```

## Practical comparisons

### Python execution path

```bash
hyperfine --warmup 2 'python script.py' 'uv run python script.py'
```

### Formatter speed

```bash
hyperfine --warmup 1 'ruff check .' 'ruff check --fix .'
```

### Build command variants

```bash
hyperfine --warmup 1 'make verify' './verify_post_install_unix'
```

## Reproducible benchmark flow

1. close noisy background apps
2. add `--warmup` for cached/runtime stabilization
3. use `--runs` for deterministic comparison
4. export results and attach to PR

Example:

```bash
hyperfine --warmup 2 --runs 10 \
  --export-markdown /tmp/bench.md \
  'python train_old.py' 'python train_new.py'
```

## Benchmarking with setup and cleanup

Use when command output or cache state affects fairness.

```bash
hyperfine \
  --prepare 'rm -rf .pytest_cache' \
  --cleanup 'rm -rf .pytest_cache' \
  'pytest -q'
```

## Engineering workflows

### Flow 1: defend a performance claim in PR

```bash
hyperfine --warmup 2 --runs 10 'cmd_old' 'cmd_new'
```

Then include exported markdown in the PR summary.

### Flow 2: profile local verify loops

```bash
hyperfine --warmup 1 'make verify' 'make leader-pack-check'
```

### Flow 3: compare shell aliases/tools

```bash
hyperfine --warmup 3 'rg TODO .' 'grep -R TODO .'
```

## Troubleshooting

### Results look unstable

- increase runs (`--runs 20`)
- isolate machine load
- use `--prepare` to reset state

### Command fails in benchmark

Check command manually first, then benchmark only passing commands.
