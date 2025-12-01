# Contributing to Puzzle-Box

Thank you for your interest in contributing to Puzzle-Box!

## Local development

To work on the project locally, you can use a Dev Container.

### Prerequisites
- Visual Studio Code
- Docker (or compatible container runtime)
- Dev Containers extension installed in VS Code

### Using a local dev container image
1. Clone this repository
2. Build the local image:
```sh
$ docker build -t puzzle-box:local .
```

3. Configure another repository (ideally, your solutions repository) to use your local dev container image
```json
// .devcontainer.json
{
  "name": "Puzzle-Box",
  "image": "puzzle-box:local",
  "mounts": [
    "source=<absolute-path-to-your-repo>/puzzle-box,target=/usr/local/puzzle-box,type=bind"
  ]
}
```

## Adding Support for a New Language

Follow these steps to add support for a new language.
It's always good to use other languages code as reference to double check your code.

1. **Create a new folder in `langs/`**
- All the script files on this folder must be executable (`chmod +x`)

2. **Create a `langs/{lang}/_util.sh` script**
- Add the language to the `available_languages` array.
- Define its file extensions in the `languages_extensions` array.
- Add any alternative names or abbreviations in the `languages_aliases` array.
- If needed, add values to `ignore_files`, it will be used to generate `.gitignore` file
- Remember to update `langs/langs.sh` to include this file

3. **Create a `langs/{lang}/setup.sh` script**
- This script should install all dependencies for the language
- Remember to update `Dockerfile` to run this file

4. **Create the Main Program File**
- `langs/{lang}/main.{ext}`.
- This file should:
    - Read input from **standard input (_stdin_)**.
    - Print the problem solution to **standard output (_stdout_)**.

5. **Create a `langs/{lang}/run.sh` script**
- This script should define how to execute `main.lang`.

_(Optional)_ If the languages requires a pre build step (like c or go), do it on this file.
- `langs/{lang}/build.sh`.

6. **Add a `langs/{lang}/format.sh` Code Format Script**
- This script should handle code formatting for the language.

7. **Add a `langs/{lang}.check.sh` script**
- Use this script to perform code linting or static analysis checks”.

8. **Add Puzzle Example Files**
- Create `part1.{ext}`, `part2.{ext}` and `part3.{ext}` in directory `langs/{lang}/template`.
- These serve as boilerplate when creating new solutions

9. **Test and Have Fun!**
- Verify your setup by solving a sample puzzle!

## Adding Support for a New Challenge
Adding a new challenge is slightly more involved. The goal is to ensure it follows a consistent standard:
- It must allow downloading the input data
- It must provide a way to fetch and store the results (e.g., expected answers)

If the challenge meets these requirements, create a new folder inside challenges/ containing the following scripts:
- `_util.sh` registers the challenge and its supported operations
- `add_session_cookie.sh` creates or updates the session cookie file required to access the challenge API
- `create.sh` scaffolds a new solution for the challenge (e.g., generating template files)
- `data.sh` retrieves metadata from the challenge API, such as the title and stored answers
- `finish.sh` marks a solution as completed (e.g., after validating the output)
- `input_file.sh` downloads and prepares the input file from the challenge API
- `validate.sh` includes validation utilities to ensure the challenge directory structure and files are correct
