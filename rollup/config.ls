require! <[
  rollup-plugin-commonjs
  rollup-plugin-node-resolve
  rollup-plugin-cpy
  rollup-plugin-json
  rollup-plugin-terser
  rollup-plugin-sizes
  ./livescript
  ./run
  ./upgrade
]>

extensions = <[ .js .ls ]>

exports <<<
  input: './src/'

  output:
    file: \client/fgh.js
    name: \fgh
    format: \iife
    sourcemap:  \inline

  plugins:
    livescript!
    run!
    rollup-plugin-json!
    rollup-plugin-terser.terser!
    upgrade rollup-plugin-sizes!
    rollup-plugin-commonjs {extensions}
    rollup-plugin-node-resolve {extensions}
    upgrade rollup-plugin-cpy do
      files: \src/static/*
      dest: \client

