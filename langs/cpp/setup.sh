#!/bin/bash

sudo apt-get update
sudo apt-get install -y build-essential clang-format

g++ --version
clang-format --version