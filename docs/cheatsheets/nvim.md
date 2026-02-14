# Neovim Cheatsheet

High-impact Neovim commands and workflows for the `utils-scripts` template.

## Start and health checks

```bash
nvim .
nvim --headless +qa
nvim --headless "+checkhealth" +qa
```

## Core navigation and search

```text
<leader>ff   find files (Telescope)
<leader>fg   live grep (Telescope)
<leader>fb   open buffers
<leader>fh   help tags
<leader>e    toggle file tree
gd           go to definition
K            hover docs
```

## Formatting and code quality

```text
<leader>fm   format current buffer (Conform)
```

Template formatter mapping includes:
- Python: `ruff_organize_imports`, `ruff_format`
- Shell/zsh: `shfmt`
- Lua: `stylua`

## AI and structure workflow

```text
<leader>cc   toggle Copilot Chat
<leader>aa   toggle Aerial symbol outline
```

Use this for fast code review loops:
1. `<leader>aa` for file structure
2. `gd`/`K` for symbol details
3. `<leader>cc` for refactor or test-generation prompts

## Testing workflow (neotest)

```text
<leader>tn   run nearest test
<leader>tf   run tests in current file
<leader>td   debug nearest test (DAP)
<leader>ts   toggle test summary panel
<leader>to   open test output
```

Typical loop:

```bash
nvim path/to/module.py
# run nearest -> inspect output -> fix -> rerun
```

## SQL workflow (Dadbod)

```text
<leader>db   toggle database UI
```

Useful Dadbod commands:

```vim
:DBUI
:DBUIAddConnection
:DBUIFindBuffer
```

## Plugin and LSP bootstrap

```vim
:Mason
```

Ensure required language servers are installed:
- `lua_ls`
- `pyright`
- `bashls`
- `jsonls`

## Practical productivity flows

### Flow 1: feature development

1. `nvim .`
2. `<leader>ff` open target file
3. `<leader>fm` format before save
4. `<leader>tn` verify nearest test

### Flow 2: code review and refactor

1. `<leader>fg` locate usages
2. `<leader>aa` inspect symbol structure
3. `<leader>cc` generate/refine patch ideas
4. `<leader>tf` run full file tests

### Flow 3: data issue investigation

1. `<leader>db` open DBUI
2. run SQL checks against staging/dev
3. switch back to code and rerun tests with `<leader>tn`
