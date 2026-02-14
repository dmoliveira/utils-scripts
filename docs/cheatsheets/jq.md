# jq Cheatsheet

High-value JSON filtering and transformation patterns for daily engineering work.

## Start

```bash
echo '{"ok":true,"items":[1,2,3]}' | jq
```

## Core selectors

```bash
jq '.status'
jq '.items[]'
jq '.items[0]'
jq '.data.name'
jq '.[0].id'
```

## Common filters

```bash
jq '.items | length'
jq '.items[] | select(.enabled == true)'
jq '.items[] | {id, name}'
jq -r '.items[].name'
```

`-r` prints raw strings (without JSON quotes), useful in shell pipelines.

## API + jq workflow

```bash
xh GET https://api.github.com/repos/dmoliveira/utils-scripts | jq '{name, stargazers_count, default_branch}'
```

## Practical transformations

### Flow 1: extract IDs

```bash
jq -r '.items[].id' response.json
```

### Flow 2: filter by condition

```bash
jq '.items[] | select(.severity == "high")' report.json
```

### Flow 3: aggregate counts

```bash
jq '[.items[] | select(.state == "open")] | length' issues.json
```

## Build JSON payloads safely

```bash
jq -n --arg name "widget" --argjson qty 3 '{name: $name, qty: $qty}'
```

## Troubleshooting

### Invalid JSON input

Validate first:

```bash
jq . data.json
```

### Missing key errors

Use optional operator:

```bash
jq '.items[]?.name?'
```
