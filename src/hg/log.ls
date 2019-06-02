require! <[ ../util/channel ../view/main ../view/error ]>

module.exports = hg-log

function hg-log
  channel do
    cmd: \run
    args: <[ hg log -T json -l 1234567890 ]>
    j$on: \*
    onerror: error
    ondata: !->
      main.append it.out.map ->
        it <<<
          date: new Date it.date[0] * 1000
          id: delete it.node
          comment: delete it.desc
