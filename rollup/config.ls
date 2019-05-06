require! <[ rollup-plugin-commonjs rollup-plugin-node-resolve rollup-plugin-cpy ./lsc ]>

exports <<<
  input: './src/'

  output:
    file: \client/fgh.js
    name: \fgh
    format: \iife

  plugins:
    rollup-plugin-commonjs!
    rollup-plugin-node-resolve!
    rollup-plugin-cpy do
      files: \src/static/*
      dest: \client
    ...

