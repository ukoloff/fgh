require! <[ ../util/channel ../view/main ../view/error ]>

module.exports = hg-log

function hg-log
  channel do
    cmd: \run
    args: <[ hg log -T json -l 1234567890 ]>
    j$on: \*
    ondata: chunk
    onerror: error

!function chunk(msg)
  main.append []
