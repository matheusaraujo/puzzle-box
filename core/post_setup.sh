#/bin/bash

apt-get clean
rm -rf /var/lib/apt/lists/*

echo "alias puzzle-box='/usr/local/puzzle-box/main.sh'" >> /home/vscode/.bashrc
echo "alias pb='/usr/local/puzzle-box/main.sh'" >> /home/vscode/.bashrc
echo "/usr/local/puzzle-box/core/welcome.sh" >> /home/vscode/.bashrc