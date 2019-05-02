setTimeout(ws)

var gitLog = {
  cmd: 'run',
  args: 'git log --all --format=' +
    "H P s an ae aI cn ce cI"
      .split(' ')
      .map(x => x + ":%" + x + "%n")
      .join('')
}

function ws() {
  var ws = new WebSocket(location.href.replace(/^http/, 'ws'))
  ws.onmessage = msg => console.log('GOT', msg)
  ws.onclose = _ => console.log('CLOSED')
  ws.onerror = _ => console.log('OOPS')
  ws.onopen = _ => {
    console.log('OPEN')
    ws.send(JSON.stringify(gitLog))
    setTimeout(close, 12345)
  }
  function close() {
    ws.close()
  }
}

