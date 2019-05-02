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

  child_process.spawn exe, args
  .on \error reject
  .stdout
  .on \end flush
  .pipe split liner

  function liner(line)
    lines.push line
    line-count += 1
    byte-count += line.length
    if line-count >= 1000 or
      byte-count >= 100000 or
      +new Date >= lastIO + 100000
      flush!

  function reset
    lines := []
    line-count := byte-count := 0
    lastIO := +new Date

  function flush
    if lines.length
      wskt.send JSON.stringify do
        out: lines
        lines: total-line-count += line-count
        bytes: total-byte-count += byte-count
      reset!
