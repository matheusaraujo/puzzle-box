import * as fs from 'fs';
import * as path from 'path';

const [dir, part] = process.argv.slice(2);

function readPipedInput(): string {
  try {
    const text = fs.readFileSync(0, 'utf8');
    return text.trim();
  } catch (error) {
    return "";
  }
}

async function main() {
  if (!dir || !part) {
    console.error("Usage: bun run main.ts <dir> <part>");
    process.exit(1);
  }

  const modulePath = path.resolve(dir, `${part}.ts`);

  try {
    const moduleUrl = `file://${modulePath}`;
    const funcModule = await import(moduleUrl);

    const exportedFunction = funcModule[part];

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