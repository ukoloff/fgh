require! <[ rollup-plugin-commonjs rollup-plugin-node-resolve ./lsc ]>

exports <<<
  input: './src/'

  output:
    file: \client/fgh.js
    name: \fgh
    format: \iife

  plugins:
    rollup-plugin-commonjs!
    rollup-plugin-node-resolve!
    ...

