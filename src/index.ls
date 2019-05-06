log-args = require \./git/log

setTimeout ws

git-log-cmd = JSON.stringify do
  cmd: \run
  args: "git log --all --format=#{logArgs.map(-> "%#{it.key}%n").join ''}"

git-log = []
pending = []

function ws
  wskt = new WebSocket location.href.replace /^http/, 'ws'
  wskt.onmessage = parse-msg
  wskt.onerror = ->
    console.log \OOPS
  wskt.onopen = ->
    wskt.send git-log-cmd

function parse-msg(msg)
  start = git-log.length

  msg = JSON.parse msg.data
  for line in msg.out
    line .= trim!
    unless line
      if pending.length == logArgs.length
        commit = {}
        for z, j in log-args
          commit[z.name] = pending[j]
        gitLog.push commit
      pending.length = 0
    else if pending.length <= logArgs.length
      pending.push if pending.length < log-args.length
        log-args[pending.length].format line

  git-log.slice start
    .map -> "<div>#{it.subj}</div>"
    .join ''
    |> document.body.insertAdjacentHTML \beforeEnd _

