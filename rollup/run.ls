require! <[ child_process ]>

module.exports = runner

transpiled = transpile!

function runner
  name: \run
  write-bundle: run

count = 0

!function run
  unless count++
    <-! transpiled.then
    child_process.spawn process.argv0, <[ . ]>, stdio: \inherit

# Start .ls -> .js transpiler
function transpile
  resolve, reject <-! new Promise _
  child_process.spawn \lsc <[ -cbo server src/server ]> do
    stdio: \inherit
    shell: true
  .on \exit resolve
  .on \error reject
