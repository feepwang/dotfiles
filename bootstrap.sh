#!/usr/bin/env bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"/nixpkgs

ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME"/nixpkgs/config.nix

git clone --recursive ${NVIM_CONFIG_URL:=https://github.com/feepwang/nvim} $XDG_CONFIG_HOME/nvim

# install Nix packages from config.nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon
source $HOME/.profile
sh <<EOF
nix-env -iA nixpkgs.neovim \
	nixpkgs.fzf \
	nixpkgs.fd \
	nixpkgs.ripgrep
EOF

