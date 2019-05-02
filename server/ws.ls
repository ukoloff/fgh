require! <[ ws ]>

module.exports = create

!function create(server)
  wss = new ws.Server {server}
  wss.on \connection connection

  var cleaner

  !function connection(wskt)
    if cleaner
      clearTimeout cleaner
      cleaner := 0

    is-alive = true
    var delegated

    wskt
    .on \message message
    .on \pong !->
      is-alive := true
    .on \close close

    setInterval sentinel, 54321

    !function close
      unless wss.clients.length
        cleaner := setTimeout bye-bye, 12345

    !function sentinel
      if !is-alive
        wskt.terminate!
      else
        is-alive := false
        wskt.ping!

    !function message(msg)
      unless delegated
        console.log \GOT msg
        wskt.send '>>>' + msg

!function bye-bye
  process.exit!
