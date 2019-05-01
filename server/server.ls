require! <[ http express ws opener ]>

app = express!
server = http.createServer app
wss = new ws.Server server: server
wss.on \connection !->
  console.log \CONNECT
  it.is-alive = true
  idle-count = 0
  it
  .on \message !->
    console.log \MSG it
    @send \>>> + it
  .on \pong !->
    @is-alive = true
  .on \close !->
    console.log \CLOSED

idle-count = 0

setInterval house-keeping, 12345

function house-keeping
  unless wss.clients.length
    if idle-count++
      process.exit!

  wss.clients.for-each !->
    if !it.is-alive
      it.terminate!
    else
      it.is-alive = false
      it.ping!

app.use express.static \static

server.listen !->
  port = @address!port
  url = "http://localhost:#{port}"
  console.log "Connect to #{url}"
  opener url
