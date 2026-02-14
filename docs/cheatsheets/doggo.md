# doggo Cheatsheet

Fast DNS debugging for development, incidents, and network sanity checks.

## Start

```bash
doggo github.com A
```

## Core query patterns

```bash
doggo openai.com A
doggo github.com AAAA
doggo github.com MX
doggo example.com TXT
doggo your-service.internal CNAME
```

## Query specific resolver

```bash
doggo openai.com A @1.1.1.1
doggo openai.com A @8.8.8.8
```

Use this to compare resolver behavior when local DNS seems inconsistent.

## Incident workflow

### Flow 1: service unreachable check

```bash
doggo api.yourdomain.com A
doggo api.yourdomain.com AAAA
doggo api.yourdomain.com CNAME
```

Confirm records exist and match expected targets.

### Flow 2: mail delivery diagnosis

```bash
doggo yourdomain.com MX
doggo selector._domainkey.yourdomain.com TXT
doggo _dmarc.yourdomain.com TXT
```

### Flow 3: compare split-horizon DNS

```bash
doggo service.internal A @10.0.0.2
doggo service.internal A @1.1.1.1
```

## Useful companion checks

```bash
xh GET https://api.yourdomain.com/health
kubectl get svc -A
```

Use DNS answers plus API/service health for faster root-cause isolation.

## Troubleshooting

### `doggo` not found

```bash
command -v doggo
make verify
```

### fallback command

```bash
nslookup github.com
```
