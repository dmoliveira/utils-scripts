# trivy Cheatsheet

Practical vulnerability scanning workflows for repos, containers, and CI checks.

## Start

```bash
trivy fs .
```

## Core scan modes

```bash
trivy fs .
trivy image python:3.12
trivy config .
```

- `fs`: scan local filesystem dependencies and known vulnerable packages
- `image`: scan container image layers and packages
- `config`: scan IaC misconfigurations (Dockerfile/Kubernetes/Terraform)

## High-value flags

```text
--severity HIGH,CRITICAL     show only important findings
--exit-code 1                fail command on findings
--format table|json          output format
--output FILE                write report file
--ignore-unfixed             suppress issues without fixes
```

Examples:

```bash
trivy fs --severity HIGH,CRITICAL --ignore-unfixed .
trivy image --severity HIGH,CRITICAL --exit-code 1 python:3.12
trivy fs --format json --output /tmp/trivy-report.json .
```

## Engineering workflows

### Flow 1: pre-PR local gate

```bash
trivy fs --severity HIGH,CRITICAL --exit-code 1 .
make verify
lazygit
```

### Flow 2: base image review

```bash
trivy image python:3.12
trivy image node:20
```

Compare risk profile before choosing base image updates.

### Flow 3: triage and remediation

1. run `trivy fs --format json --output /tmp/trivy.json .`
2. inspect top HIGH/CRITICAL findings
3. update dependencies or base image
4. rerun scan and attach results in PR notes

## Useful companion commands

```bash
make shell-lint
make verify
trivy fs .
```

## Troubleshooting

### Slow first run

- first run downloads vulnerability DB; subsequent runs are faster.

### Want fewer noisy findings

```bash
trivy fs --severity HIGH,CRITICAL --ignore-unfixed .
```

### Validate only one path

```bash
trivy fs path/to/subproject
```
