#!/usr/bin/env bash
set -euo pipefail

tmux_conf="${TMUX_CONF:-$HOME/.tmux.conf}"
tpm_dir="$HOME/.tmux/plugins/tpm"
install_plugins="$tpm_dir/bin/install_plugins"
update_plugins="$tpm_dir/bin/update_plugins"
required_plugins=(tmux-sensible tmux-cpu)

if ! command -v tmux >/dev/null 2>&1; then
	echo "tmux is not installed; run make install-unix first"
	exit 1
fi

if [[ ! -f "$tmux_conf" ]]; then
	echo "tmux config not found at $tmux_conf"
	exit 1
fi

if [[ ! -x "$install_plugins" ]]; then
	echo "Installing TPM..."
	git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
fi

echo "Reloading tmux config..."
tmux start-server >/dev/null 2>&1 || true
tmux source-file "$tmux_conf"

echo "Installing tmux plugins..."
"$install_plugins"

echo "Updating tmux plugins..."
if ! "$update_plugins" all; then
	echo "tmux plugin update failed; continuing with current plugin set"
fi

missing=0
for plugin in "${required_plugins[@]}"; do
	if [[ -d "$HOME/.tmux/plugins/$plugin" ]]; then
		echo "plugin ok: $plugin"
	else
		echo "plugin missing: $plugin"
		missing=1
	fi
done

if grep -Eq "set -g @qol_status_plugins 'on'" "$tmux_conf"; then
	for plugin in tmux-battery tmux-network-bandwidth; do
		if [[ -d "$HOME/.tmux/plugins/$plugin" ]]; then
			echo "plugin ok: $plugin"
		else
			echo "plugin missing (qol enabled): $plugin"
			missing=1
		fi
	done
fi

if command -v numfmt >/dev/null 2>&1; then
	echo "formatter ok: numfmt"
elif command -v gnumfmt >/dev/null 2>&1; then
	echo "formatter ok: gnumfmt"
else
	echo "formatter missing: numfmt/gnumfmt"
	if [[ "$(uname -s)" == "Darwin" ]]; then
		echo "install hint: brew install coreutils"
	else
		echo "install hint: sudo apt install -y coreutils"
	fi
	missing=1
fi

tmux source-file "$tmux_conf"
if [[ -n "${TMUX:-}" ]]; then
	tmux display-message "tmux self-heal complete"
fi

if [[ "$missing" -ne 0 ]]; then
	exit 1
fi
