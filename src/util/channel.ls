# Websocket communication to backend

module.exports = channel


!function channel(options)
  wskt = new WebSocket location.href.replace /^http/, 'ws'
  wskt.onopen = ->
    wskt.send JSON.stringify options
  wskt.onmessage = on-msg
  wskt.onerror = on-error

  !function on-msg(msg)
    try
      msg = JSON.parse msg.data
      if msg.error
        on-error msg.error
      else
        options.ondata? msg
        if msg.done
          on-end!
    catch err
      on-error err

  !function on-error(error)
    options.onerror? error
    on-end!

  !function on-end
    options.onend?!
