require! <[ ws ]>

module.exports = create

!function create(server)
  wss = new ws.Server {server}
  wss.on \connection connection

  var cleaner

  !function connection(wskt)
    if cleaner
      clear-timeout cleaner
      cleaner := 0

    is-alive = true
    var delegated

    wskt
    .on \message message
    .on \pong !->
      is-alive := true
    .on \close close

    pinger = set-interval sentinel, 54321

    !function close
      clear-interval pinger
      unless wss.clients.length
        cleaner := set-timeout bye-bye, 12345

    !function sentinel
      if !is-alive
        wskt.terminate!
      else
        is-alive := false
        wskt.ping!

    !function message(msg)
      unless delegated
        Promise.resolve msg
        .then JSON.parse
        .then ->
          msg := it
          it ?.= cmd
          if /^\w+$/.test it
            it
          else
            \#
        .then ->
          try
            require "./cmd/#{it}"
          catch
            require "./cmd/oops"
        .then ->
          delegated := true
          it wskt, msg
        .catch !->
          wskt.send JSON.stringify do
            error: it.message
            stack: it.stack
        .then !->
          delegated := false

!function bye-bye
  process.exit!
