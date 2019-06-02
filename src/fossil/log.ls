require! <[ ../util/channel ../view/main ../view/error ]>

module.exports = fossil-checkins

function fossil-checkins
  channel do
    cmd: \run
    args: <[ fossil json timeline checkin -n 0 ]>
    j$on: \payload.timeline.*
    ondata: chunk
    onerror: error

!function chunk(msg)
  main.append []
