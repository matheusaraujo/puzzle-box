#!/bin/bash

set -euo pipefail

export RUSTUP_HOME=/usr/local/rustup
export CARGO_HOME=/usr/local/cargo

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y --no-modify-path --profile minimal --default-toolchain stable

/usr/local/cargo/bin/rustup default stable
/usr/local/cargo/bin/rustup component add rustfmt
/usr/local/cargo/bin/rustup component add clippy

cat >/etc/profile.d/rust.sh <<'EOF'
export RUSTUP_HOME=/usr/local/rustup
export CARGO_HOME=/usr/local/cargo
export PATH=/usr/local/cargo/bin:$PATH
EOF

chmod +x /etc/profile.d/rust.sh
