# GNU Parallel Cheatsheet

Run command batches concurrently with predictable output grouping.

## Core examples

```bash
parallel echo ::: one two three
parallel -j 4 "python {}" ::: scripts/*.py
parallel --bar "curl -fsS {} >/dev/null" :::: urls.txt
```

## Practical repo flow

```bash
fd -e md docs | parallel -j 4 "glow -p {} >/dev/null"
```

Use `-j` to cap concurrency and keep machine load stable.
