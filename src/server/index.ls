require! <[ path http express opener ./ws ./args ]>

if args.args.length
  process.chdir args.args[0]

app = express!
ws server = http.createServer app

__dirname
  |> path.join _, \../client
  |> express.static
  |> app.use

require.resolve \bootswatch/package
  |> path.join _, \../dist
  |> express.static
  |> app.use

require.resolve \font-awesome/package
  |> path.dirname
  |> express.static
  |> app.use

server.listen args.port || 0 \localhost !->
  port = @address!port
  url = "http://localhost:#{port}"
  if args.prompt
    console.log "Connect to #{url}"
  if args.browser
    opener url
