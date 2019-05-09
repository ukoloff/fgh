require! <[ mithril ./view/main ./view/head ./util/channel ./util/root ]>
log-args = require \./git/log

setTimeout !->
  mithril.mount document.head, head

  <-! root!.then

  channel do
    cmd: \run
    args: "git log --all --format=#{logArgs.map(-> "%#{it.key}%n").join ''}"
    ondata: chunk
    onerror: error

!function error(err)
  console.log \OOPS err

var mounted
git-log = []
pending = []

!function chunk(msg)
  unless mounted
    mounted := true
    mithril.mount document.body, main git-log

  for line in msg.out
    line .= trim!
    unless line
      if pending.length == log-args.length
        commit = {}
        for z, j in log-args
          commit[z.name] = pending[j]
        git-log.push commit
      pending.length = 0
    else if pending.length <= log-args.length
      pending.push if pending.length < log-args.length
        log-args[pending.length].format line

  mithril.redraw!
