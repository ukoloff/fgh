require! <[ rollup-plugin-commonjs rollup-plugin-node-resolve rollup-plugin-cpy ./lsc ./livescript ./run ]>

exts =
  extensions: <[ .js .ls ]>

exports <<<
  input: './src/'

  output:
    file: \client/fgh.js
    name: \fgh
    format: \iife

  plugins:
    livescript!
    run!
    rollup-plugin-commonjs do
      exts
    rollup-plugin-node-resolve do
      exts
    rollup-plugin-cpy do
      files: \src/static/*
      dest: \client
    ...

