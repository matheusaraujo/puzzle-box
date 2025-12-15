import * as fs from 'fs';
import * as path from 'path';

// The shell script passes: $relative_dir $event $day $part
// process.argv contains [bun, scriptPath, arg1, arg2, ...]
const [dir, event, day, part] = process.argv.slice(2);

/**
 * Reads all piped input from STDIN (file descriptor 0).
 * @returns The input as a single trimmed string.
 */
function readPipedInput(): string {
  try {
    // Read from file descriptor 0 (stdin) to process piped input
    // Using fs.readFileSync(0) is the standard Node/Bun way for blocking STDIN read.
    const text = fs.readFileSync(0, 'utf8');
    return text.trim();
  } catch (error) {
    return "";
  }
}

async function main() {
  if (!dir || !part) {
    console.error("Usage: bun run main.ts <dir> <event> <day> <part>");
    process.exit(1);
  }

  // Construct the absolute path to the solution file (.ts extension)
  const modulePath = path.resolve(dir, `${part}.ts`);

  try {
    // Bun can directly import and run TypeScript files
    // Convert local path to a file:// URL for dynamic import compatibility
    const moduleUrl = `file://${modulePath}`;
    const funcModule = await import(moduleUrl);

    // Get the exported function that matches the part name (e.g., 'part1')
    const exportedFunction = funcModule[part];

    // Split the input into an array of lines, consistent with your existing scripts
    const inputData = readPipedInput().split('\n');

    if (typeof exportedFunction === 'function') {
      const result = exportedFunction(inputData);
      console.log(result);
    } else {
      console.error(`Error: The imported file ${modulePath} does not export a function named '${part}'.`);
      process.exit(1);
    }
  } catch (error) {
    console.error(`Error running puzzle part ${part} from ${modulePath}:`, (error as Error).message || error);
    process.exit(1);
  }
}

main();