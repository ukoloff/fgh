require! <[ path http express opener ./ws ./args ]>

if args.args.length
  process.chdir args.args[0]

app = express!
ws server = http.createServer app

app.use express.static path.join __dirname, \../static

server.listen args.port || 0 !->
  port = @address!port
  url = "http://localhost:#{port}"
  console.log "Connect to #{url}"
  if args.browser
    opener url
