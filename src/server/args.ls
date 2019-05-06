require! <[ commander ]>

module.exports = commander
  .version do
    require \../package .version
  .option '-p, --port <port>', 'Port to listen on (default = 0 = ephemeral)'
  .option '-b, --no-browser', 'Do not run browser'
  .option '-P, --no-prompt', 'Do not prompt for browser start'
  .parse process.argv
