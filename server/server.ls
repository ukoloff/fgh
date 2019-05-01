require! <[ http express ws opener ]>

app = express!
server = http.createServer app
wss = new ws.Server server: server
wss.on \connection !->
  console.log \CONNECT
  it
  .on \message !->
    console.log \MSG it
    @send \>>> + it
  .on \close !->
    console.log \CLOSED

app.use express.static \static

server.listen !->
  port = @address!port
  url = "http://localhost:#{port}"
  console.log "Connect to #{url}"
  opener url
