require! <[ child_process ]>

module.exports = runner

function runner
  name: \run
  write-bundle: run

count = 0

!function run
  unless count++
    child_process.spawn process.argv0, <[ . ]>, stdio: \inherit
