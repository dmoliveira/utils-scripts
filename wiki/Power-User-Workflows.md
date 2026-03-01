# Power User Workflows

## Tight delivery loop

```bash
tmux-delivery
watchexec -e py,sh,lua,md 'make verify'
lazygit
```

## Reliability gate

```bash
make doctor-full
trivy fs .
```

## Incident loop

```bash
tmux-incident
procs --sortd cpu
kubectl get pods -A
doggo github.com MX
```

## Continue marker

`CONTINUE_TAG: #continue-utils`
