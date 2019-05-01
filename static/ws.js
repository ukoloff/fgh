setTimeout(ws)

function ws() {
  var ws = new WebSocket(location.href.replace(/^http/, 'ws'))
  ws.onmessage = msg => console.log('GOT', msg)
  ws.onclose = _ => console.log('CLOSED')
  ws.onerror = _ => console.log('OOPS')
  ws.onopen = _ => {
    console.log('OPEN')
    ws.send('Hello, world!')
    setTimeout(close, 12345)
  }
  function close() {
    ws.close()
  }
}
