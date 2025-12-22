const [dir, part] = Deno.args;

function readPipedInput() {
  const text = new TextDecoder().decode(Deno.readFileSync("/dev/stdin"));
  return text.trim();
}

async function main() {
  const modulePath = `${dir}/${part}.js`;
  const moduleUrl = new URL(modulePath, `file://${Deno.cwd()}/`).href;

  const funcModule = await import(moduleUrl);

  const exportedFunction = funcModule[part];

  const inputData = readPipedInput().split("\n");

  if (typeof exportedFunction === 'function') {
    console.log(exportedFunction(inputData));
  } else {
    console.error(`The imported file ${modulePath} does not export a default function.`);
  }
}

main();