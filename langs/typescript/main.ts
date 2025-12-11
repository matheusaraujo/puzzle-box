import * as fs from 'fs';

const [, , dir, , , part] = process.argv;

let func: object = require(`${dir}/${part}.ts`);

function main() {
  const inputData = fs.readFileSync(0, 'utf-8')
    .trim()
    .split("\n");

  const exportedFunction = (func as any).default || func;


  console.log(exportedFunction(inputData));
}

main();