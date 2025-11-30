const fs = require('fs');

const [,, dir, , , part] = process.argv;

let func = require(`${dir}/${part}.js`);

function main() {
  const input_data = fs.readFileSync(0, 'utf-8')
    .trim()
    .split("\n");
  console.log(func(input_data));
}

main();
