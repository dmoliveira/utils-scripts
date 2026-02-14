# 🧰 utils-scripts  

> Personal collection of setup scripts for building a high-performance AI/ML developer environment — terminal, shell, editor, and Python stack — optimised for Unix/Debian and macOS.

[![License: GPL-2.0](https://img.shields.io/badge/License-GPL--2.0-blue.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Debian%20%7C%20macOS-lightgrey.svg)]()
[![Donate via Stripe](https://img.shields.io/badge/Donate-Stripe-blue?logo=stripe&logoColor=white)](https://buy.stripe.com/8x200i8bSgVe3Vl3g8bfO00)

---

## 🧭 Table of Contents  
1. [Motivation](#motivation)  
2. [What’s Included](#whats-included)  
3. [Supported Platforms](#supported-platforms)  
4. [Installation](#installation)  
5. [Usage](#usage)  
6. [Terminal Playbook](#terminal-playbook)  
7. [Tool Cheatsheets](#tool-cheatsheets)
8. [Post-Install Verification](#post-install-verification)  
9. [Configuration & Customisation](#configuration--customisation)  
10. [Troubleshooting](#troubleshooting)  
11. [Releases](#releases)  
12. [Contributing](#contributing)  
13. [Support](#support)  
14. [License](#license)  

---

## 💡 Motivation  
As a Senior Engineering Manager and Principal in AI/ML, I often rebuild new environments for experiments, demos, or teaching.  
This repo standardises and automates my setup for:

- ⚙️ Configuring a **modern shell** (`zsh`, `starship`, `tmux`)  
- 🧑‍💻 Installing a **Python + ML toolchain** with key libraries  
- 🪄 Setting up **Neovim** for fast and extensible Python development  
- 💻 Supporting **Debian/Ubuntu** and **macOS** systems  
- 🚀 Maximising developer productivity and terminal performance  

Everything is tuned to work well together — lightweight, consistent, and fast.

---

## 📦 What’s Included  
| File | Description |
|------|--------------|
| `install_my_programs_debian` | Installs core packages on Debian/Ubuntu |
| `install_my_programs_mac` | Installs core packages on macOS (via Homebrew) |
| `install_my_programs_unix` | Generic fallback for Unix systems |
| `Makefile` | Standard shortcuts for install and verification |
| `doctor_post_install_unix` | Strict doctor mode with fix hints |
| `bootstrap_shell_secrets` | Interactive helper for shell secrets setup |
| `br_init_project` | Initialize `.beads/` + AGENTS.md with `br` conventions |
| `verify_linux_edge_cases` | Linux-specific command-variant checks |
| `requirements.txt` | Python and AI/ML library dependencies |
| `run_commands/` | Helper utilities and shell functions |
| `run_commands/nvim/lua/utils_scripts/` | Modular Neovim template modules |
| `run_commands/my_ghostty_config` | Ghostty terminal baseline config |
| `run_commands/my_starship.toml` | Starship prompt baseline config |
| `run_commands/secrets_shell.env.example` | Secure shell secrets template |
| `verify_post_install_unix` | End-to-end setup smoke test script |
| `rollback_installer_backups` | Restore latest installer backup files |
| `.github/RELEASE_NOTES_TEMPLATE.md` | Structured release notes template used by release workflow |
| `TERMINAL_PLAYBOOK.md` | Practical workflows and tool scenarios |
| `docs/cheatsheets/*.md` | Per-tool power-user cheatsheets and workflows |
| `python/` | Additional Python utility scripts |
| `.gitignore` | Standard ignore patterns |
| `LICENSE` | GPL-2.0 License file |

Includes dependencies for:  
- **Terminal:** tmux, zsh, starship, ghostty, atuin, direnv, htop, btop  
- **Editor:** neovim (Lua config-ready)  
- **Python:** numpy, pandas, torch, scikit-learn, transformers (editable)  
- **Optional:** lazygit, hyperfine, dua-cli, dust, procs, xh, doggo, watchexec, kubectl, k9s, trivy, zellij, git, curl, wget, build-essentials  

---

## 🧩 Supported Platforms  
✅ **Debian / Ubuntu**  
✅ **macOS**  
⚠️ Other Unix flavours may work but aren’t officially tested.

---

## ⚙️ Installation  

### 1️⃣ Clone the Repository  
```bash
git clone https://github.com/dmoliveira/utils-scripts.git
cd utils-scripts
```

### 2️⃣ Choose and Run Your Installer  

**Using Make shortcuts (recommended):**
```bash
make help
make install-mac
```

**Debian / Ubuntu:**
```bash
chmod +x install_my_programs_debian
./install_my_programs_debian
./install_my_programs_debian --dry-run
```

**macOS:**
```bash
chmod +x install_my_programs_mac
./install_my_programs_mac
./install_my_programs_mac --dry-run
```

**Generic Unix:**
```bash
chmod +x install_my_programs_unix
./install_my_programs_unix
./install_my_programs_unix --dry-run
```

Optional flags (Generic Unix):
- `--dry-run` preview actions without modifying the machine
- `--skip-ml` skip AI/ML Python packages
- `--skip-fonts` skip Nerd Fonts install

Dry-run behavior:
- prints each planned command with `[dry-run] ...`
- keeps hardware/OS branching so previews remain realistic
- performs no filesystem/package-manager mutations

Issue-tracker helper note:
- use `br_init_project` for new repos; `bd_init_project` is kept only as a compatibility wrapper

Monitoring install behavior:
- `btop` is installed on macOS and Linux as the default modern monitor
- macOS installs `bottom` (`btm`) as the `nvtop` alternative
- Apple Silicon (`arm64`) attempts to install `asitop` when available in Homebrew
- Linux installs `nvtop` only when GPU hardware is detected and apt package is available

Advanced tool install behavior:
- macOS installs all recommended tools via Homebrew when formulas are available
- Linux installs each tool only when an apt package exists (auto-skip otherwise)
- Linux `kubectl` tries `kubectl` first and falls back to `kubernetes-client`
- The installer avoids duplicate installs and prints clear installed/skipped status

### 3️⃣ Install Python Packages (optional)
```bash
pip install -r requirements.txt
```

### 4️⃣ Run the Post-Install Smoke Test
```bash
chmod +x verify_post_install_unix
./verify_post_install_unix
```

or with Make:
```bash
make verify
```

Additional modes:
```bash
./verify_post_install_unix --strict
./verify_post_install_unix --json
make verify-strict
make verify-json
make doctor
make verify-linux
make playbook
make leader-pack-check
make rollback
make rollback-dry-run
make shell-lint
```

Rollback helper:
```bash
./rollback_installer_backups --list
./rollback_installer_backups --dry-run
./rollback_installer_backups
```

The installers also manage `~/.config/starship.toml` from `run_commands/my_starship.toml` and create timestamped backups before replacing it.

Pull requests also run repository smoke checks in GitHub Actions (`.github/workflows/smoke-checks.yml`).
Installer and verification changes also run a disposable Ubuntu golden-path bootstrap workflow (`.github/workflows/golden-path-bootstrap.yml`).
Shell scripts are linted in CI with shellcheck + shfmt (`.github/workflows/shell-lint.yml`).

---

## 🧠 Usage  
After installation you’ll have:  

- **zsh + starship** prompt with Git & Python awareness  
- **tmux** for persistent terminal sessions  
- **neovim** configured for Python and AI workflows  
- **Python environment** ready with key ML libraries  

Example:
```bash
tmux new -s ai_env
nvim my_script.py
```

For Neovim productivity:
- `:Ex` → File explorer  
- `<leader>f` → Fuzzy search  
- `gd` → Go to definition  
- `K` → Hover docs  

---

## 📘 Terminal Playbook

For practical "what to run when" workflows, see:

- `TERMINAL_PLAYBOOK.md`

Leader-pack helpers from `run_commands/my_zshrc`:

- `leader-pack-help` to print shortcuts
- `tmux-research` for benchmarking + monitoring + coding
- `tmux-delivery` for edit + verify loop + security checks
- `tmux-incident` for live triage (system, k8s, DNS)
- `make playbook` to quickly locate the playbook file
- `make leader-pack-check` to validate playbook + zsh template wiring

---

## 🗂️ Tool Cheatsheets

Per-tool, power-user guides live in:

- `docs/cheatsheets/tmux.md`
- `docs/cheatsheets/zsh.md`
- `docs/cheatsheets/nvim.md`
- `docs/cheatsheets/starship.md`
- `docs/cheatsheets/lazygit.md`
- `docs/cheatsheets/btop.md`
- `docs/cheatsheets/hyperfine.md`
- `docs/cheatsheets/procs.md`
- `docs/cheatsheets/xh.md`
- `docs/cheatsheets/doggo.md`
- `docs/cheatsheets/trivy.md`
- `docs/cheatsheets/kubectl.md`
- `docs/cheatsheets/k9s.md`
- `docs/cheatsheets/watchexec.md`
- `docs/cheatsheets/direnv.md`
- `docs/cheatsheets/atuin.md`
- `docs/cheatsheets/dua.md`
- `docs/cheatsheets/dust.md`
- `docs/cheatsheets/gh.md`
- `docs/cheatsheets/zoxide.md`
- `docs/cheatsheets/fd.md`

Each cheatsheet includes:
- top commands to memorize
- practical examples
- high-leverage workflows for engineering and incident response

---

## ✅ Post-Install Verification

Run the smoke test script after installation to validate your terminal stack:

```bash
./verify_post_install_unix
```

It checks:
- required CLI tools (`zsh`, `tmux`, `nvim`, `fzf`, `zoxide`, `starship`, `direnv`, `atuin`)
- monitoring tools (`btop` plus `btm` on macOS, `nvtop` on Linux with detected GPU)
- advanced productivity tools (`lazygit`, `hyperfine`, `dua`, `dust`, `procs`, `xh`, `doggo`, `watchexec`, `kubectl`, `k9s`, `trivy`, `zellij`) as optional checks
- expected config files (`~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/init.lua`)
- syntax/startup checks for Zsh, tmux, and Neovim
- Ghostty config validation on macOS when installed

If the script reports `FAIL > 0`, fix those items before continuing.

Verification flags:
- `--strict` treats warnings as failures (useful for CI and clean-room setup validation)
- `--json` prints a machine-readable summary (`status`, `strict`, `pass`, `warn`, `fail`)

Doctor mode:
- `make doctor` runs strict verification and prints actionable fix hints for common failures.

---

## 🔧 Configuration & Customisation  

### Shell
Edit your `~/.zshrc` or add functions in `~/.zsh.d/` for modularity.  
Example alias:
```bash
alias gs='git status'
alias py='python3'
```

Template extras in `run_commands/my_zshrc`:
- `zsh-history-substring-search` + `fzf-tab` for better recall/completion UX
- `direnv` hook for per-project env loading
- `atuin` hook for searchable shell history
- `ghostty-reload` helper to validate and edit Ghostty config quickly
- leader-pack shortcuts: `lg`, `hf`, `dui`, `ds`, `px`, `hget`, `dns`, `k`, `kga`, `tfscan`
- tmux templates: `tmux-research`, `tmux-delivery`, `tmux-incident`

Secrets best practice:
```bash
mkdir -p ~/.config/secrets
cp ./run_commands/secrets_shell.env.example ~/.config/secrets/shell.env
chmod 600 ~/.config/secrets/shell.env
```

Interactive helper:
```bash
./bootstrap_shell_secrets
# or
make bootstrap-secrets
```

### Starship Prompt
Config file: `~/.config/starship.toml`
Base config in this repo: `run_commands/my_starship.toml`
Power-user reference: `docs/cheatsheets/starship.md`

```bash
mkdir -p ~/.config
cp ./run_commands/my_starship.toml ~/.config/starship.toml
starship explain
```

Keep personal prompt tweaks in a clearly marked block so they are easy to remove later.

Template defaults include:
- compact git dirtiness counts only when dirty (example: `+2 !1 ?3`)
- command-duration tiers: show after 2s, notify after 15s

```toml
[git_branch]
symbol = " "

[python]
symbol = " "
```

### tmux
Edit `~/.tmux.conf` for shortcuts, layouts and themes.  
Example:
```
set -g mouse on
bind r source-file ~/.tmux.conf \; display "Reloaded!"
```

Template defaults also include `tmux-sensible` and an opt-in switch for status plugins:
```
set -g @qol_status_plugins 'off'   # change to 'on' for battery/network status plugins
```

Session persistence defaults are also enabled via TPM plugins:
```
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'
set -g @continuum-restore 'on'
```

### Monitoring tools
- Use `btop` as your default monitor for CPU, memory, processes, and IO
- On macOS, `btm` (bottom) is installed as the richer TUI alternative to `htop`
- On Apple Silicon, `asitop` is installed when available to expose SoC metrics
- On Linux with a detected GPU, `nvtop` is installed when the package exists

### Productivity tools quick guide
- `lazygit`: fast interactive Git UI; start with `lazygit`, stage with `space`, commit with `c`
- `hyperfine`: benchmark commands reliably; use `hyperfine 'python script.py' 'uv run python script.py'`
- `dua` and `dust`: inspect disk usage quickly; run `dua i` for interactive mode and `dust -d 3` for top folders
- `procs`: modern process viewer; try `procs --sortd cpu` or `procs python`
- `xh`: readable HTTP client; use `xh GET https://api.github.com/repos/dmoliveira/utils-scripts`
- `doggo`: DNS debugging; use `doggo openai.com A` or `doggo github.com MX`
- `watchexec`: rerun on file changes; `watchexec -e py 'pytest -q'`
- `kubectl` and `k9s`: Kubernetes CLI + TUI; run `kubectl get pods -A` then `k9s`
- `trivy`: security scan for files/images; `trivy fs .` and `trivy image python:3.12`
- `zellij`: terminal workspace manager; start with `zellij` and split panes from built-in help (`Ctrl-g` + `?`)

### WezTerm
Config file: `~/.wezterm.lua`  
Base config in this repo: `run_commands/my_wezterm.lua`
```
cp ./run_commands/my_wezterm.lua ~/.wezterm.lua
```

### Ghostty
Config file: `~/.config/ghostty/config`  
Base config in this repo: `run_commands/my_ghostty_config`
```
mkdir -p ~/.config/ghostty
cp ./run_commands/my_ghostty_config ~/.config/ghostty/config
```

### Neovim
Modify `~/.config/nvim/init.lua` to adjust plugins or keymaps.  
Power-user reference: `docs/cheatsheets/nvim.md`

Template defaults include:
- LSP support (`pyright`, `lua_ls`)  
- Formatter orchestration (`conform.nvim`)  
- AI workflow (`CopilotChat.nvim`)  
- Code navigation (`aerial.nvim`)  
- Test workflow (`neotest`, `neotest-python`)  
- SQL workflow (`vim-dadbod`, `vim-dadbod-ui`)  
- Core UI/search (`nvim-treesitter`, `telescope.nvim`, `lualine.nvim`)

Template defaults now include Mason bootstrap for language servers:
```
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "pyright", "bashls", "jsonls" } })
```

The Neovim template is modularized under:
- `run_commands/my_nvim_init.lua`
- `run_commands/nvim/lua/utils_scripts/plugins.lua`
- `run_commands/nvim/lua/utils_scripts/options.lua`
- `run_commands/nvim/lua/utils_scripts/lsp.lua`
- `run_commands/nvim/lua/utils_scripts/keymaps.lua`
- `run_commands/nvim/lua/utils_scripts/ui.lua`

After opening Neovim, run:
```
:Mason
```

Useful default keymaps:
- `<leader>fm` format current buffer
- `<leader>cc` Copilot Chat toggle
- `<leader>aa` Aerial outline toggle
- `<leader>tn` run nearest test
- `<leader>tf` run tests in current file
- `<leader>ts` toggle neotest summary
- `<leader>to` open neotest output
- `<leader>td` debug nearest test with DAP
- `<leader>db` toggle Dadbod UI

### Python
Keep `requirements.txt` up to date with your preferred ML stack.  
Recommended additions:
```
xgboost
lightgbm
sentence-transformers
gradio
mlflow
```

---

## 🛠️ Troubleshooting

### Ghostty config warning in `verify_post_install_unix`
If you see `Ghostty config validation failed`, run:
```bash
/Applications/Ghostty.app/Contents/MacOS/ghostty +validate-config --config-file ~/.config/ghostty/config
```
Fix the reported key/value and rerun `make verify`.

### `--strict` mode fails on warnings
`./verify_post_install_unix --strict` intentionally converts warnings into failures.
Use strict mode in CI or when validating a clean machine setup.

### Missing `xterm-ghostty` terminfo
If terminal features look incorrect in tmux/Neovim under Ghostty, use `term = xterm-256color` in `~/.config/ghostty/config` until `xterm-ghostty` terminfo is available on your system.

### Linux command-name variants (`fd`/`fdfind`, `bat`/`batcat`)
On Debian/Ubuntu, packages install commands as `fdfind` and `batcat`.
Run:
```bash
make verify-linux
```
If needed, install variants with:
```bash
sudo apt install -y fd-find bat
```

### Secrets file not loaded by Zsh
Ensure `~/.config/secrets/shell.env` exists and has safe permissions:
```bash
chmod 600 ~/.config/secrets/shell.env
```
You can bootstrap it with:
```bash
make bootstrap-secrets
```

### Revert config files after an installer run
Installers create timestamped backups like `~/.zshrc.<timestamp>.bak`.
Use:
```bash
make rollback-dry-run
make rollback
```

---

## 🚀 Releases

Releases are automated through GitHub Actions when a version tag is pushed.

Workflow:
- `.github/workflows/release-on-tag.yml`
- `.github/RELEASE_NOTES_TEMPLATE.md`
- Trigger: push tag matching `v*` (example: `v1.2.0`)
- Outcome: GitHub Release created with structured notes sections (`Adds`, `Changes`, `Fixes`, `Removals`) plus generated changelog entries

Template workflow details:
- release workflow renders `.github/RELEASE_NOTES_TEMPLATE.md` using current tag/date
- placeholders supported: `{{VERSION}}`, `{{DATE}}`
- update template content before tagging if you want custom release messaging

Recommended release flow:
1. update `.github/RELEASE_NOTES_TEMPLATE.md` with release highlights
2. create and push your version tag
3. review the generated GitHub Release notes and publish

Preview template rendering locally:
```bash
VERSION=v1.2.0
DATE_UTC="$(date -u +%Y-%m-%d)"
sed "s/{{VERSION}}/${VERSION}/g; s/{{DATE}}/${DATE_UTC}/g" .github/RELEASE_NOTES_TEMPLATE.md
```

Example:
```bash
git tag v1.2.0
git push origin v1.2.0
```

---

## 🤝 Contributing  
Contributions, feedback and improvements are welcome!  
1. Fork this repo  
2. Create a new branch (`git checkout -b feature/your-feature`)  
3. Commit and push your changes  
4. Open a pull request  

Please make sure your scripts are portable and keep dependencies minimal.

---

## ❤️ Support  
If this project helped you save time or setup headaches, consider supporting:  

[![Donate via Stripe](https://img.shields.io/badge/Donate-Stripe-blue?logo=stripe&logoColor=white)](https://buy.stripe.com/8x200i8bSgVe3Vl3g8bfO00)

Your contribution helps keep these utilities maintained and up to date.

---

## 📜 License  
This project is licensed under the [GNU GPL-2.0 License](LICENSE).  

---

**Author:** [Diego Marinho](https://github.com/dmoliveira)  
**Repository:** [github.com/dmoliveira/utils-scripts](https://github.com/dmoliveira/utils-scripts)  
**Last Updated:** 2026-02-13
