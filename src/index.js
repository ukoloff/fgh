var logArgs = require('./git/log')

setTimeout(ws)

var gitLogCmd = {
  cmd: 'run',
  args: 'git log --all --format=' +
    logArgs.map(x => '%' + x.key + "%n")
      .join('')
}

var gitLog = [], pending = []

function ws() {
  var ws = new WebSocket(location.href.replace(/^http/, 'ws'))
  ws.onmessage = parseMsg
  // ws.onclose = _ => console.log('CLOSED')
  ws.onerror = _ => console.log('OOPS')
  ws.onopen = _ => {
    // console.log('OPEN')
    ws.send(JSON.stringify(gitLogCmd))
  }
}

function parseMsg(msg) {
  var start = gitLog.length

  msg = JSON.parse(msg.data)
  for (var i = 0; i < msg.out.length; ++i) {
    var line = msg.out[i].trim()
    if (!line) {
      if (pending.length == logArgs.length) {
        var commit = {}
        for (var j = 0; j < logArgs.length; ++j)
          commit[logArgs[j].name] = pending[j]
        gitLog.push(commit)
      }
      pending = []
      continue;
    }
    if (pending.length <= logArgs.length)
      pending.push(pending.length == logArgs.length ? false : logArgs[pending.length].format(line))
  }

  document.body.insertAdjacentHTML('beforeEnd', gitLog.slice(start).map(gitLine).join(''))
}

function gitLine(line) {
  return '<div>' + line.subj + '</line>'
}
