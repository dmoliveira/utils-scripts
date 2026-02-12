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
6. [Post-Install Verification](#post-install-verification)  
7. [Configuration & Customisation](#configuration--customisation)  
8. [Troubleshooting](#troubleshooting)  
9. [Contributing](#contributing)  
10. [Support](#support)  
11. [License](#license)  

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
| `bootstrap_shell_secrets` | Interactive helper for shell secrets setup |
| `requirements.txt` | Python and AI/ML library dependencies |
| `run_commands/` | Helper utilities and shell functions |
| `run_commands/nvim/lua/utils_scripts/` | Modular Neovim template modules |
| `run_commands/my_ghostty_config` | Ghostty terminal baseline config |
| `run_commands/secrets_shell.env.example` | Secure shell secrets template |
| `verify_post_install_unix` | End-to-end setup smoke test script |
| `python/` | Additional Python utility scripts |
| `.gitignore` | Standard ignore patterns |
| `LICENSE` | GPL-2.0 License file |

Includes dependencies for:  
- **Terminal:** tmux, zsh, starship, ghostty, atuin, direnv  
- **Editor:** neovim (Lua config-ready)  
- **Python:** numpy, pandas, torch, scikit-learn, transformers (editable)  
- **Optional:** git, curl, wget, build-essentials  

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
```

**macOS:**
```bash
chmod +x install_my_programs_mac
./install_my_programs_mac
```

**Generic Unix:**
```bash
chmod +x install_my_programs_unix
./install_my_programs_unix
```

Optional flags (Generic Unix):
- `--skip-ml` skip AI/ML Python packages
- `--skip-fonts` skip Nerd Fonts install

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
```

Pull requests also run repository smoke checks in GitHub Actions (`.github/workflows/smoke-checks.yml`).

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

## ✅ Post-Install Verification

Run the smoke test script after installation to validate your terminal stack:

```bash
./verify_post_install_unix
```

It checks:
- required CLI tools (`zsh`, `tmux`, `nvim`, `fzf`, `zoxide`, `starship`, `direnv`, `atuin`)
- expected config files (`~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/init.lua`)
- syntax/startup checks for Zsh, tmux, and Neovim
- Ghostty config validation on macOS when installed

If the script reports `FAIL > 0`, fix those items before continuing.

Verification flags:
- `--strict` treats warnings as failures (useful for CI and clean-room setup validation)
- `--json` prints a machine-readable summary (`status`, `strict`, `pass`, `warn`, `fail`)

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
```toml
[character]
success_symbol = "🚀 "
error_symbol = "💥 "
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
Consider adding:
- LSP support (`pyright`, `lua_ls`)  
- Formatter (`black`, `ruff`)  
- Plugins (`nvim-treesitter`, `telescope.nvim`, `lualine.nvim`)

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

### Secrets file not loaded by Zsh
Ensure `~/.config/secrets/shell.env` exists and has safe permissions:
```bash
chmod 600 ~/.config/secrets/shell.env
```
You can bootstrap it with:
```bash
make bootstrap-secrets
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
**Last Updated:** 2025-11-02
