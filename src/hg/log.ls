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
  main.append msg.out.map mapper

function mapper(commit)
  commit <<<
    date: new Date commit.date[0] * 1000
    id: delete commit.node
    comment: delete commit.desc
