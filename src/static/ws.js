setTimeout(ws)

var logFields = {
  id: { H: id },
  up: { P: split },
  subj: { s: id },
  aname: { an: id },
  amail: { ae: id },
  adate: { aI: date },
  cname: { cn: id },
  cmail: { ce: id },
  cdate: { cI: date },
}

var logArgs = parseFields(logFields)

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

function id(it) {
  return it
}

function split(it) {
  return it.split(/\s+/)
}

function date(it) {
  return new Date(it)
}

function parseFields(f) {
  var result = []
  for (var k in f) {
    var v = f[k]
    var z
    for (z in v) break
    result.push({ name: k, key: z, format: v[z] })
  }
  return result
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
