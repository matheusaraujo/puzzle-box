# Puzzle-Box

![logo.png](docs/logo.png)

![Version](https://img.shields.io/badge/version-0.0.10-blue)
### Supported Languages
![Assembly](https://img.shields.io/badge/Assembly-000000?style=for-the-badge&logo=assemblyai&logoColor=white)
![C](https://img.shields.io/badge/C-00599C?style=for-the-badge&logo=c&logoColor=white)
![C#](https://img.shields.io/badge/C%23-239120?style=for-the-badge&logo=c-sharp&logoColor=white)
![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![Java](https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=java&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![Lisp](https://img.shields.io/badge/Lisp-BC0000?style=for-the-badge&logo=common-lisp&logoColor=white)
![Perl](https://img.shields.io/badge/Perl-39457E?style=for-the-badge&logo=perl&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Rust](https://img.shields.io/badge/Rust-000000?style=for-the-badge&logo=rust&logoColor=white)
![TypeScript](https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=typescript&logoColor=white)

Puzzle-Box is a Dev Container environment designed to help you solve programming challenges, such as **Advent of Code** and **Everybody Codes**, in multiple languages with a unified workflow.

## Getting Everything Ready 🚀

Puzzle-Box is designed to run inside a **VS Code Dev Container environment**.

### Prerequisites
- Visual Studio Code
- Docker (or another container runtime)
- Dev Containers extension installed in VS Code

### Steps
1. Create a `.devcontainer/devcontainer.json` file in your repository and reopen it using Dev Container VS Code extension (or from GitHub UI)

```json
{
  "name": "Puzzle-Box",
  "image": "maraujo127/puzzle-box:{version}"
}
```

2. When your container is ready, run the following commands to set up your repository

```bash
# Initialize your repository for Puzzle-Box
$ puzzle-box setup-repository
# or
$ pb setup-repository

# Add your session cookie for the challenge provider (Advent of Code or Everybody Codes)
# To get your cookie: open the challenge site, inspect a request,
# and copy the session cookie value
$ pb add-session-cookie ecd
```

## Solving a Puzzle 🧩

```bash
# Create boilerplate solution files for:
# Advent of Code / year 2015 / day 1 / using C
$ puzzle-box create aoc 2015 1 c

# to add sample input
$ puzzle-box generate-input part1

# Run your solution in watch mode (auto-rebuild & re-run)
$ puzzle-box run -w

# Format your code using language-specific formatting rules
$ pb format

# Run static analysis / linting
$ pb check

# Commit your solution
$ pb commit
```