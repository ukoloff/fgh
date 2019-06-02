require! <[ ../util/run ]>

module.exports = root
root.scm =
  name: \git
  log: require \./log

function root
  run args: "git rev-parse --show-toplevel"
  .then ->
    it[0]
