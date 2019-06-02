require! <[ ../util/channel ../view/main ../view/error ]>

module.exports = fossil-checkins

function fossil-checkins
  channel do
    cmd: \run
    args: <[ fossil json timeline checkin -n 0 ]>
    j$on: \payload.timeline.*
    onerror: error
    ondata: !->
      main.append it.out.map ->
        it <<<
          id: delete it.uuid
          date: new Date 1000 * delete it.timestamp
