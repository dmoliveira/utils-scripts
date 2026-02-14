# kubectl Cheatsheet

Safe, high-signal Kubernetes command patterns for daily operations and incident response.

## Safety first

```bash
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <context>
```

Always verify context/namespace before mutating resources.

## Core diagnostics

```bash
kubectl get pods -A
kubectl get svc -A
kubectl get deploy -A
kubectl describe pod <pod> -n <ns>
kubectl logs <pod> -n <ns> --tail=200
kubectl logs -f <pod> -n <ns>
```

## Namespace and resource targeting

```bash
kubectl get pods -n <ns>
kubectl get pods -n <ns> -l app=<name>
kubectl get all -n <ns>
```

## Rollout operations

```bash
kubectl rollout status deploy/<name> -n <ns>
kubectl rollout history deploy/<name> -n <ns>
kubectl rollout restart deploy/<name> -n <ns>
kubectl rollout undo deploy/<name> -n <ns>
```

## Incident workflows

### Flow 1: pod crashloop triage

```bash
kubectl get pods -n <ns>
kubectl describe pod <pod> -n <ns>
kubectl logs <pod> -n <ns> --previous
```

### Flow 2: service unreachable

```bash
kubectl get svc -n <ns>
kubectl get endpoints -n <ns>
kubectl get pods -n <ns> -l app=<name>
```

### Flow 3: safe deploy verification

```bash
kubectl apply -f k8s/ -n <ns>
kubectl rollout status deploy/<name> -n <ns>
kubectl get pods -n <ns>
```

## JSON output and quick parsing

```bash
kubectl get pods -n <ns> -o wide
kubectl get pod <pod> -n <ns> -o json | jq '.status.containerStatuses'
kubectl get events -n <ns> --sort-by=.metadata.creationTimestamp
```

## Useful companions

```bash
k9s
doggo service.internal A
xh GET https://api.yourdomain.com/health
```

## Troubleshooting

### Forbidden errors

- check current context and RBAC permissions before retrying.

### API server timeout

```bash
kubectl cluster-info
kubectl get nodes
```
