require! <[ child_process split JSONStream ]>

module.exports = run

function run(wskt, options)
  {args, j$on} = options
  if \string == typeof args
    args .= split /\s+/
  exe = args.shift!
  resolve, reject <-! new Promise _

  var mute
  var lines, line-count, byte-count, lastIO
  reset!
  total-line-count = total-byte-count = 0
  start-time = +new Date

  child_process.spawn exe, args
  .on \error ->
    reject it
    mute := true
  .on \close !->
    resolve!
    flush do
      done: true
      code: it
  .stdout
  .pipe if j$on
    JSONStream.parse j$on
    .on \data jsoner
  else
    split liner

  !function liner(line)
    lines.push line
    line-count += 1
    byte-count += line.length
    if line-count >= 777 or
      byte-count >= 100000 or
      +new Date >= lastIO + 100
      flush!

  !function jsoner(data)
    lines.push data
    line-count += 1
    if line-count >= 108 or
      +new Date >= lastIO + 100
      flush!

  function reset
    lines := []
    line-count := byte-count := 0
    lastIO := +new Date

  function flush(data)
    if !mute and (lines.length or data)
      data ||= {}
      data <<<
        out: lines
        lines: total-line-count += line-count
        bytes: total-byte-count += byte-count
        ms:    +new Date - start-time
      wskt.send JSON.stringify data
      reset!
