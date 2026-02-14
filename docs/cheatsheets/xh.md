# xh Cheatsheet

Fast API debugging with a human-friendly HTTP client.

## Start

```bash
xh GET https://api.github.com/repos/dmoliveira/utils-scripts
```

## Core request patterns

```bash
xh GET https://api.example.com/health
xh POST https://api.example.com/items name=widget qty:=3
xh PUT https://api.example.com/items/42 status=active
xh DELETE https://api.example.com/items/42
```

`key=value` sends strings, `key:=value` sends raw JSON values.

## Headers and auth

```bash
xh GET https://api.example.com/me Authorization:"Bearer $TOKEN"
xh GET https://api.example.com/me X-Request-Id:debug-123
xh --auth user:pass GET https://api.example.com/private
```

## JSON-first workflows

```bash
xh GET https://api.example.com/items | jq '.data[] | {id, name}'
xh POST https://api.example.com/items name=widget tags:='["ops","ml"]'
```

## Practical debugging flows

### Flow 1: endpoint sanity check

```bash
xh GET https://api.example.com/health
xh GET https://api.example.com/version
```

### Flow 2: auth regression check

```bash
xh GET https://api.example.com/me Authorization:"Bearer $TOKEN"
xh GET https://api.example.com/me Authorization:"Bearer invalid"
```

### Flow 3: API contract validation in PRs

```bash
xh GET https://api.example.com/items?page:=1&limit:=20
xh POST https://api.example.com/items name=test qty:=1
```

## Useful flags

```text
--print=HhBb   control request/response output sections
--offline      build and print request without sending
--timeout N    set request timeout seconds
--follow       follow redirects
```

Examples:

```bash
xh --offline POST https://api.example.com/items name=preview
xh --timeout 5 --follow GET http://example.com
```

## Troubleshooting

### TLS/cert issue in local env

Use a trusted dev cert chain; avoid disabling verification unless temporary.

### Quick fallback comparison

```bash
curl -i https://api.example.com/health
```
