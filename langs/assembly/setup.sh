#!/bin/bash

# Install NASM and build-essential (includes default gcc/ld)
apt-get update
apt-get install -y nasm build-essential

# FIX: Install the specific cross-linker toolchain for x86-64,
# which is needed for linking x86-64 binaries on an ARM64 host.
apt-get install -y binutils-x86-64-linux-gnu