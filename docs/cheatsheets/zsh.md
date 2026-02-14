# zsh Cheatsheet

High-leverage zsh commands and flows for the `utils-scripts` environment.

## Reload and validate quickly

```bash
exec zsh
source ~/.zshrc
zsh -n ~/.zshrc
```

## History power moves

```bash
history 1
fc -ln -20
atuin search "kubectl"
```

Template behavior includes history substring search on arrow keys and shared history across sessions.

## Navigation and discovery

```bash
z repo-name
zi repo-name
pwd
```

`z`/`zi` come from `zoxide` integration in the template.

## Environment and secrets flow

```bash
direnv allow
echo "$OPENAI_API_KEY"
```

Secrets file convention:

```bash
~/.config/secrets/shell.env
chmod 600 ~/.config/secrets/shell.env
```

## Completion and shell helpers

```bash
leader-pack-help
ghostty-reload
```

Useful aliases in template:

```bash
gs      # git status
lg      # lazygit
hf      # hyperfine
dui     # dua interactive
px      # procs
tfscan  # trivy fs .
```

## Practical power-user flows

### Flow 1: fast repo start

```bash
z utils-scripts
tm
nvim .
```

### Flow 2: pre-PR quality pass

```bash
make verify
make shell-lint
tfscan
lg
```

### Flow 3: incident triage shell loop

```bash
tmux-incident
procs --sortd cpu
doggo your-service.internal A
kubectl get pods -A
```

## Debug shell startup slowness

```bash
time zsh -i -c exit
zsh -xlic exit 2> /tmp/zsh-startup.log
```

Use this when plugin or completion startup feels slow.
