#!/usr/bin/sh

# Install basic CLI tools (curl, git, neovim) using available package manager
PACKAGES="curl git neovim"

# Determine whether we need sudo
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
else
    SUDO=""
fi

install_with_apt() {
    $SUDO apt-get update -y || { echo "apt-get update failed" >&2; return 1; }
    $SUDO apt-get install -y --no-install-recommends $PACKAGES
}

echo "Detected package managers and installing: $PACKAGES"

if command -v apt-get >/dev/null 2>&1; then
    if ! install_with_apt; then
        echo "apt-get installation failed" >&2
    fi
else
    echo "Error: no supported package manager found (apt-get, dnf, yum, pacman, apk)" >&2
fi

# Verify installation
for cmd in curl git nvim; do
    if command -v "$cmd" >/dev/null 2>&1; then
        echo "OK: $cmd is installed -> $(command -v $cmd)"
    else
        echo "WARN: $cmd is not available after installation" >&2
    fi
done

# Dotfiles installation script
# Step 1: Create symlinks for git and nvim config directories to $XDG_CONFIG_HOME

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Create config directory if it doesn't exist
mkdir -p "$XDG_CONFIG_HOME"

# Get the script directory (repository root)
REPO_DIR="$(dirname $0)"

# Symlink git config
if [ -d "$REPO_DIR/git" ]; then
    ln -sf "$REPO_DIR/git" "$XDG_CONFIG_HOME/git"
    echo "Created symlink: $XDG_CONFIG_HOME/git -> $REPO_DIR/git"
fi

cp -f $REPO_DIR/gitconfig.template $HOME/.gitconfig

# Symlink nvim config
if [ -d "$REPO_DIR/nvim" ]; then
    ln -sf "$REPO_DIR/nvim" "$XDG_CONFIG_HOME/nvim"
    echo "Created symlink: $XDG_CONFIG_HOME/nvim -> $REPO_DIR/nvim"
fi

# Initialize SSH directory and permissions
SSH_DIR="${SSH_DIR:-$HOME/.ssh}"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"
echo "Initialized SSH directory: $SSH_DIR (mode 700)"

# Download public keys and set authorized_keys
SSH_PUBLIC_KEYS_URL="https://github.com/feepwang.keys"
curl -fsSL -o ${SSH_DIR}/authorized_keys ${SSH_PUBLIC_KEYS_URL}
chown 744 ${SSH_DIR}/authorized_keys
