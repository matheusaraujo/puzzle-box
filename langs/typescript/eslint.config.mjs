// NOTE: We destructure the parts we need from the package
import { configs, parser } from "typescript-eslint";
// The parser is also available as a default export, but this is the modern convention

/** @type {import("eslint").Linter.FlatConfig[]} */
export default [
  // 1. Apply the recommended base configuration
  ...configs.recommended,

  {
    files: ["**/*.ts"],
    languageOptions: {
      // 2. Use the new parser location
      parser: parser,
      parserOptions: {
        project: "./tsconfig.eslint.tmp.json",
      },
      ecmaVersion: "latest",
      sourceType: "module",
    },
    rules: {
      // Add TypeScript-specific custom rules here
    },
  },
];