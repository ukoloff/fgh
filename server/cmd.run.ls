require! <[ child_process split ]>

module.exports = run

function run(wskt, args)
  args .= args
  if \string == typeof args
    args .= split /\s+/
  exe = args.shift!
  resolve, reject <-! new Promise _

  var lines, line-count, byte-count, lastIO
  reset!
  total-line-count = total-byte-count = 0
  start-time = +new Date

  child_process.spawn exe, args
  .on \error reject
  .on \close !->
    flush do
      done: true
      code: it
  .stdout
  .pipe split liner

  function liner(line)
    lines.push line
    line-count += 1
    byte-count += line.length
    if line-count >= 1000 or
      byte-count >= 100000 or
      +new Date >= lastIO + 100
      flush!

  function reset
    lines := []
    line-count := byte-count := 0
    lastIO := +new Date

  function flush(data)
    if lines.length or data
      data ||= {}
      data <<<
        out: lines
        lines: total-line-count += line-count
        bytes: total-byte-count += byte-count
        ms:    +new Date - start-time
      wskt.send JSON.stringify data
      reset!
