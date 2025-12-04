# Puzzle-Box

![logo.png](docs/logo.png)

![Version](https://img.shields.io/badge/version-0.0.4-blue)
![Languages](https://img.shields.io/badge/supported%20languages-c%20csharp%20go%20java%20js%20perl%20python-success)

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