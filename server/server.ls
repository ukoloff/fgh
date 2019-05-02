require! <[ http express opener ./ws ]>

app = express!
ws server = http.createServer app

app.use express.static \static

server.listen !->
  port = @address!port
  url = "http://localhost:#{port}"
  console.log "Connect to #{url}"
  opener url


