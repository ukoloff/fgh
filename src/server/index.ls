require! <[ path connect serve-static opener ./ws ./args ]>

if args.args.length
  process.chdir args.args[0]

app = connect!

__dirname
  |> path.join _, \../client
  |> serve-static
  |> app.use

require.resolve \bootswatch/package
  |> path.join _, \../dist
  |> serve-static
  |> app.use

require.resolve \font-awesome/package
  |> path.dirname
  |> serve-static
  |> app.use

app.listen args.port || 0 \localhost !->
  ws @
  port = @address!port
  url = "http://localhost:#{port}"
  if args.prompt
    console.log "Connect to #{url}"
  if args.browser
    opener url
