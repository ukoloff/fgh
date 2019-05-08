require! <[ ./channel ]>

module.exports = run

function run(options)
  resolve, reject <-! new Promise _

  lines = []

  options <<<
    cmd: \run
    ondata: !->
      if it.code
        reject Error "Program exit with code ##{it.code}"
      else if it.out
        lines.push ...that
    onerror: reject
    onend: !->
      resolve lines

  channel options
