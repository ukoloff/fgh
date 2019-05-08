require! <[ ./channel ]>

module.exports = run

function run(options)
  options <<<
    cmd: \run
    ondata: on-data
    onerror: on-error
    onend: on-end

