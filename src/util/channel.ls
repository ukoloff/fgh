# Websocket communication to backend

module.exports = channel

free-sockets = []
queue = []
running = 0

!function channel(options)
  var wsckt

  if free-sockets.length
    reuse free-sockets.pop!
  else if running
    queue.push reuse
    delay 50
    .then reuse
  else
    reuse!

  function reuse(socket)
    unless wsckt
      running++
      if is-new = !socket
        socket = new WebSocket location.href.replace /^http/ 'ws'
      wsckt := socket
      socket.onmessage = on-msg
      socket.onerror = on-error
      if is-new
        socket.onopen = fire
      else
        fire!
      true

  !function fire
    wsckt.send JSON.stringify options

  !function on-error(error)
    send-error error, true

  !function send-error(error, fatal)
    options.onerror? error
    on-end fatal

  !function on-end(fatal)
    running--
    options.onend?!
    wsckt.onmessage =
      wsckt.onerror =
        wsckt.onopen = void

    if fatal
      wsckt.close!
      unless running
        while queue.length
          if queue.shift!!
            break
    else
      while queue.length
        if queue.shift! wsckt
          return
      free-sockets.push wsckt

  !function on-msg(msg)
    try
      msg = JSON.parse msg.data
      if msg.error
        send-error msg.error
      else
        options.ondata? msg
        if msg.done
          on-end!
    catch err
      on-error err

function delay(ms)
  resolve <-! new Promise _
  setTimeout resolve, ms
