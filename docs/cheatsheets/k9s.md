# k9s Cheatsheet

Interactive Kubernetes triage with fast keyboard workflows.

## Start

```bash
k9s
```

## Core navigation keys

```text
?            show key help
q            quit / back
:pods        jump to pods view
:deploy      jump to deployments
:svc         jump to services
0-9          switch namespaces (when mapped)
/            filter in current view
Ctrl-a       show all namespaces
```

## Most useful actions

```text
l            view logs for selected resource
s            open shell into selected container
d            describe selected resource
e            edit resource (careful in prod)
Shift-f      port-forward selected service/pod
Ctrl-d       delete selected resource (dangerous)
```

## Safe triage workflow

1. confirm context/namespace at top bar
2. open `:pods`
3. filter by app using `/`
4. inspect logs (`l`) and describe (`d`)
5. switch to `:deploy` for rollout status

## Incident workflows

### Flow 1: crashloop diagnosis

```text
:pods -> /<app-name> -> select pod -> l -> d
```

Then verify with CLI:

```bash
kubectl logs <pod> -n <ns> --previous
kubectl describe pod <pod> -n <ns>
```

### Flow 2: rollout verification

```text
:deploy -> /<service> -> select deploy -> d
```

Then:

```bash
kubectl rollout status deploy/<name> -n <ns>
```

### Flow 3: service exposure check

```text
:svc -> /<service>
```

Use port-forward action (`Shift-f`) for local health checks.

## Companion commands

```bash
kubectl config current-context
kubectl get pods -A
doggo service.internal A
```

## Troubleshooting

### Wrong cluster/context

Exit and switch context first:

```bash
kubectl config use-context <context>
k9s
```

### Missing permissions

RBAC restrictions will show forbidden errors in views/actions; verify role bindings before retrying.
