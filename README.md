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
6. [Configuration & Customisation](#configuration--customisation)  
7. [Contributing](#contributing)  
8. [Support](#support)  
9. [License](#license)  

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
| `requirements.txt` | Python and AI/ML library dependencies |
| `run_commands/` | Helper utilities and shell functions |
| `python/` | Additional Python utility scripts |
| `.gitignore` | Standard ignore patterns |
| `LICENSE` | GPL-2.0 License file |

Includes dependencies for:  
- **Terminal:** tmux, zsh, starship  
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

### 3️⃣ Install Python Packages (optional)
```bash
pip install -r requirements.txt
```

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

## 🔧 Configuration & Customisation  

### Shell
Edit your `~/.zshrc` or add functions in `~/.zsh.d/` for modularity.  
Example alias:
```bash
alias gs='git status'
alias py='python3'
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

### Neovim
Modify `~/.config/nvim/init.lua` to adjust plugins or keymaps.  
Consider adding:
- LSP support (`pyright`, `lua_ls`)  
- Formatter (`black`, `ruff`)  
- Plugins (`nvim-treesitter`, `telescope.nvim`, `lualine.nvim`)

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
